# Stage 1: Clone the repository and build the project
FROM node:16-buster AS build

# Install Git
RUN apt-get update && apt-get install -y git

# Define build argument for the branch or tag
ARG BRANCH=master

# Clone the specified branch or tag
RUN git clone --branch ${BRANCH} https://github.com/open-nomie/nomie6-oss.git /usr/src/app

# Set working directory
WORKDIR /usr/src/app

# Install dependencies
RUN npm install

# Build the project
RUN npm run vbuild

# Stage 2: Serve the built project using Nginx
FROM nginx:alpine

# Copy the built files from the build stage
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

