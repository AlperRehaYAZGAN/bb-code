#! /bin/bash

echo "[BB-TERMINAL] OnInit - ENV Loading from remote additional environment variables repository" > /tmp/bb-on-init-service.log

ENV_URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/additional.env"
ISENVSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISENVSUCCESS -eq 200 ]; then
    echo "[BB-TERMINAL] ENV - envs are loading..." >> /tmp/bb-terminal-service.log
    curl -s $ENV_URL > /tmp/additional.env
    source /tmp/additional.env
    echo "[BB-TERMINAL] ENV - envs loaded" >> /tmp/bb-terminal-service.log
fi


# load init-script from repository
# if repository returns non-200 code. Use default : "/usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash;"
# curl -s https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads | bash

URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads"
ISSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISSUCCESS -eq 200 ]; then
    echo "[BB-TERMINAL] SCRIPT - Script is downloading..." >> /tmp/bb-terminal-service.log
    curl -s $URL | bash
    echo "[BB-TERMINAL] SCRIPT - Script completed" >> /tmp/bb-terminal-service.log
else
    echo "[BB-TERMINAL] SCRIPT - Script is not found. Using default script." >> /tmp/bb-terminal-service.log
    /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash;
fi
