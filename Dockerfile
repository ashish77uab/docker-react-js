# =========================================
# Single Stage: Build and Serve React.js Application
# =========================================
ARG NODE_VERSION=24.7.0-alpine

# Use a lightweight Node.js image
FROM node:${NODE_VERSION}

# Set the working directory inside the container
WORKDIR /app

# Copy package-related files first to leverage Docker's caching mechanism
COPY package.json package-lock.json ./

# Install project dependencies
RUN --mount=type=cache,target=/root/.npm npm install

# Copy the rest of the application source code into the container
COPY . .

# Build the React.js application
RUN npm run build

# Install a simple static file server
RUN npm install -g serve

# Expose port 3000 (default for serve)
EXPOSE 8080

# Serve the built React app
CMD ["serve", "-s", "build", "-l", "3000"]