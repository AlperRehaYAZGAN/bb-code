# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-postgres15-v1.0.0
# stage 1 - build
FROM alperreha/bb-ubuntu:22.04-term-v1.0.0

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Ubuntu 22.04 Postgresql-15, ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Ubuntu 22.04 Postgresql 15 Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# Add some additional env variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ="Europe/Istanbul"

# Install Postgres required packages
RUN apt-get update && \
    apt-get install -y \ 
    curl \
    ca-certificates \
    postgresql-common

RUN sudo install -d /usr/share/postgresql-common/pgdg \
    && sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    && sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && sudo apt update -y

# update and install postgresql
RUN apt-get -y install postgresql-15 postgresql-contrib

# Set the default postgres user password
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$(ls /etc/postgresql)/main/pg_hba.conf \
    && echo "listen_addresses='*'" >> /etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf \
    && echo "export PS1='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[00m\] $ '" >> /var/lib/postgresql/.bashrc

# Enable postgresql service
RUN systemctl enable postgresql

# remove unnecessary files in ubuntu before commit
RUN rm -rf /var/cache/apt/* \
    /var/tmp/* \
    && apt-get clean

