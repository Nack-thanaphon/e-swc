# Base image
FROM node:16.13

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install 

# Install Angular CLI
RUN npm install -g @angular/cli

RUN npm update @angular/cli

RUN ng config -g cli.warnings.versionMismatch false

# Copy app files
COPY . .

# Build app for production
RUN ng build --configuration=production

# Install nginx
RUN apt-get update \
    && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

# Configure nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start nginx and serve the application
CMD ["nginx", "-g", "daemon off;"]
