#! /bin/bash

echo "[BB-ONINIT] OnInit - Script has started." > /tmp/bb-on-init-service.log

ENV_URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-on-init/additional.env"
ISENVSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISENVSUCCESS -eq 200 ]; then
  echo "[BB-ONINIT] ENV - envs are loading..." >> /tmp/bb-on-init-service.log
  curl -s $ENV_URL > /tmp/on-init-additional.env
  export $(grep -v '^#' /tmp/on-init-additional.env | xargs)
  echo "[BB-ONINIT] ENV - envs loaded" >> /tmp/bb-on-init-service.log
else 
    echo "[BB-ONINIT] ENV - envs are not found." >> /tmp/bb-on-init-service.log
fi


# if "INIT_SCRIPT_URL" given, download and run it
if [ -n "$INIT_SCRIPT_URL" ]; then
  echo "[BB-ONINIT] OnInit - INIT_SCRIPT_URL env found set and try downloading... $INIT_SCRIPT_URL" >> /tmp/bb-on-init-service.log
  curl -s $INIT_SCRIPT_URL | /bin/bash
  echo "[BB-ONINIT] OnInit - INIT_SCRIPT_URL completed" >> /tmp/bb-on-init-service.log
fi

echo "[BB-ONINIT] OnInit - Script Run Completed" >> /tmp/bb-on-init-service.log

# in the end create /tmp/ready file to indicate that service is ready
touch /tmp/ready
