# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-alpine:3.19-term-compose-v1.0.0
# stage 1 - build
FROM alperreha/bb-alpine:3.19-term-v2.0.0

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Alpine with docker, compose, ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Alpine Docker-Compose Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# install docker
RUN apk update && \
    apk add --no-cache docker docker-compose

ADD https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker /etc/bash_completion.d/docker.sh


# move all services to supervisor conf.d
ADD ./services/dockerd.ini /etc/supervisor.d/
