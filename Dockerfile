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

# Build app
RUN ng build --configuration=production

# Expose port
EXPOSE 80

# Start server
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
