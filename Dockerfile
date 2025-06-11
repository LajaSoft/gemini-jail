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

# RUN mkdir /var/run/sshd
# ## version will be here!
RUN npm install -g @anthropic-ai/claude-code

USER ${USER_ID}




