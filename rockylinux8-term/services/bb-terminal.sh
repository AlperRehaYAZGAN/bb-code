#! /bin//bin/bash

/usr/bin/echo "[BB-TERMINAL] OnInit - ENV Loading from remote additional environment variables repository" > /tmp/bb-terminal-service.log

ENV_URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/additional.env"
ISENVSUCCESS=$(/usr/bin/curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISENVSUCCESS -eq 200 ]; then
    /usr/bin/echo "[BB-TERMINAL] ENV - envs are loading..." >> /tmp/bb-terminal-service.log
    /usr/bin/curl -s $ENV_URL > /tmp/terminal-additional.env
    export $(grep -v '^#' /tmp/terminal-additional.env | /usr/bin/xargs)
    /usr/bin/echo "[BB-TERMINAL] ENV - envs loaded" >> /tmp/bb-terminal-service.log
fi 
else 
    /usr/bin/echo "[BB-TERMINAL] ENV - envs are not found." >> /tmp/bb-terminal-service.log
fi


# load init-script from repository
# if repository returns non-200 code. Use default : "/usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true /bin/bash;"
# /usr/bin/curl -s https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads | /bin/bash

URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads"
ISSUCCESS=$(/usr/bin/curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISSUCCESS -eq 200 ]; then
    /usr/bin/echo "[BB-TERMINAL] SCRIPT - Script is downloading..." >> /tmp/bb-terminal-service.log
    /usr/bin/curl -s $URL | /bin/bash
    /usr/bin/echo "[BB-TERMINAL] SCRIPT - Script completed" >> /tmp/bb-terminal-service.log
else
    /usr/bin/echo "[BB-TERMINAL] SCRIPT - Script is not found. Using default script." >> /tmp/bb-terminal-service.log
    /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true /bin/bash;
fi
