FROM alpine:latest

# Build arguments for user and group IDs
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_GID=10000

RUN apk update && apk add --no-cache bash curl nodejs npm openssh coreutils docker docker-compose git

# # Create docker group and add user to it
RUN delgroup docker && \
    addgroup -g ${DOCKER_GID} docker && \
    adduser -D -u ${USER_ID} -g ${GROUP_ID} -h /home/claude-code -s /bin/bash claude-user &&\
    addgroup claude-user docker
USER ${USER_ID}

# Set paths for Node.js
# Priority will be /home/claude-code/node_modules (runtime)
# Then /home/claude-install/node_modules (base installation)
ENV PATH="/home/claude-code/node_modules/.bin:/home/claude-install/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV NODE_PATH="/home/claude-code/node_modules:/home/claude-install/node_modules"
WORKDIR /home/claude-install

# Create directory for base package installation
RUN mkdir -p /home/claude-install/node_modules
# Set prefix for npm in runtime
RUN npm config set prefix /home/claude-code/node_modules
# Install base package in the installation directory
RUN npm install --prefix /home/claude-install @anthropic-ai/claude-code

# RUN mkdir /var/run/sshd
# ## version will be here!
