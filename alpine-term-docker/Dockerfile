# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb:alpine3.19-term-2.0.0
# stage 1 - build
FROM alperreha/bb-alpine:3.19-term-v2.0.0

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Alpine with docker, ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Alpine Docker Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# install docker
RUN apk update && \
    apk add --no-cache docker

# move all services to supervisor conf.d
ADD ./services/* /etc/supervisor.d/*

# DONT CHANGE ENTRYPOINT
CMD [ "/usr/bin/docker-entrypoint.sh" ]