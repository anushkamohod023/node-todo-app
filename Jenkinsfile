pipeline {
    agent { label 'dev-server' }

    environment {
        IMAGE_NAME = "node-app"
        CONTAINER  = "node-app-container"
        SONARQUBE  = "Sonar"
        OWASP_DC   = "OWASP"
    }

    stages {
        stage("Clone Code") {
            steps {
                git url: "https://github.com/anushkamohod023/node-todo-app.git", branch: "master"
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv("${SONARQUBE}") {
                    sh "sonar-scanner -Dsonar.projectKey=node-app -Dsonar.sources=."
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("OWASP Dependency Check") {
            steps {
                dependencyCheck additionalArguments: '--scan ./', odcInstallation: "${OWASP_DC}"
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage("Docker Build") {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage("Trivy Scan") {
            steps {
                sh "trivy image ${IMAGE_NAME}:latest || true"
            }
        }

        stage("Deploy") {
            steps {
                sh '''
                    docker stop ${CONTAINER} || true
                    docker rm ${CONTAINER} || true
                    docker run -d --name ${CONTAINER} -p 8000:8000 ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "DevSecOps Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for errors."
        }
    }
}
