# Use official Node 18 Alpine image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first 
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Run tests 
RUN npm test

# Expose port 
EXPOSE 8000

# Start the app
CMD ["node", "app.js"]
