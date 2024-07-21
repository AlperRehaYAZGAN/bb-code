#! /bin/bash

echo "[BB-TERMINAL] OnInit - ENV Loading from remote additional environment variables repository" > /tmp/bb-terminal-service.log

ENV_URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/additional.env"
ISENVSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $ENV_URL)
if [ $ISENVSUCCESS -eq 200 ]; then
    echo "[BB-TERMINAL] ENV - envs are loading..." >> /tmp/bb-terminal-service.log
    curl -s $ENV_URL > /tmp/terminal-additional.env
    export $(grep -v '^#' /tmp/terminal-additional.env | xargs)
    echo "[BB-TERMINAL] ENV - envs loaded" >> /tmp/bb-terminal-service.log
else 
    echo "[BB-TERMINAL] ENV - envs are not found." >> /tmp/bb-terminal-service.log
fi

# unset
unset ENV_URL
unset ISENVSUCCESS

# load init-script from repository
# if repository returns non-200 code. Use default : "bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true /bin/bash;"
# curl -s https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads | /bin/bash
export $(grep -v '^#' /tmp/image.env | xargs)

URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads"
ISSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISSUCCESS -eq 200 ]; then
    echo "[BB-TERMINAL] SCRIPT - Script is downloading..." >> /tmp/bb-terminal-service.log
    curl -s $URL | /bin/bash
    echo "[BB-TERMINAL] SCRIPT - Script completed" >> /tmp/bb-terminal-service.log
else
    # unset
    unset URL
    unset ISSUCCESS

    echo "[BB-TERMINAL] SCRIPT - Script is not found. Using default script." >> /tmp/bb-terminal-service.log
    bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true /bin/bash;
fi
