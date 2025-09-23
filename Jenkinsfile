pipeline {
    agent { label 'dev-server' }

    environment {
        IMAGE_NAME = "node-app"
        CONTAINER  = "node-app-container"
    }

    stages {
        stage("Code Clone") {
            steps {
                echo "Cloning repository..."
                git url: "https://github.com/anushkamohod023/node-todo-app.git", branch: "master"
            }
        }

        stage("Build Image") {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploying container locally..."
                sh '''
                    docker stop ${CONTAINER} || true
                    docker rm ${CONTAINER} || true
                    docker run -d --name ${CONTAINER} -p 3000:3000 ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
