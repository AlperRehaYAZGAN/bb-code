#! /bin/bash

# start terminal
echo "[INFO] OnInit - ENV Loading additional environment variables" > /tmp/bb-on-init-service.log

ENV_URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-on-init/additional.env"
ISSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISSUCCESS -eq 200 ]; then
    curl -s $ENV_URL > /tmp/additional.env
    source /tmp/additional.env
fi

# if "INIT_SCRIPT_URL" given, download and run it
if [ -n "$INIT_SCRIPT_URL" ]; then
  echo "[INFO] OnInit - INIT_SCRIPT_URL is downloading... $INIT_SCRIPT_URL" >> /tmp/bb-on-init-service.log
  curl -s $INIT_SCRIPT_URL | bash
  echo "[INFO] OnInit - INIT_SCRIPT_URL completed" >> /tmp/bb-on-init-service.log
fi

echo "[INFO] OnInit - Completed" >> /tmp/bb-on-init-service.log

# in the end create /tmp/ready file to indicate that service is ready
touch /tmp/ready
