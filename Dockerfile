FROM alpine:latest

# Build arguments for user and group IDs
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_GID=10000

RUN apk update && apk add --no-cache bash curl nodejs npm openssh coreutils docker docker-compose git vim

# # Create docker group and add user to it
RUN delgroup docker && \
    addgroup -g ${DOCKER_GID} docker && \
    adduser -D -u ${USER_ID} -g ${GROUP_ID} -h /home/gemini-cli -s /bin/bash gemini-user &&\
    addgroup gemini-user docker
USER ${USER_ID}
# Set paths for Node.js
# Priority will be /home/gemini-cli/node_modules (runtime)
# Then /home/gemini-install/node_modules (base installation)
ENV PATH="/home/gemini-cli/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
RUN npm config set prefix ~
WORKDIR /home/gemini-install
