# Node Base Image
FROM node:18-alpine

# Working Directory
WORKDIR /app

# Copy all code
COPY . .

# Install the dependencies
RUN npm install

# Run tests 
RUN npm test

# Expose port 
EXPOSE 3000

# Run the code
CMD ["node", "app.js"]

