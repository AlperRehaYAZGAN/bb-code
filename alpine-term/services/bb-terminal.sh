#! /bin/bash

# load init-script from repository
# if repository returns non-200 code. Use default : "/usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash;"
# curl -s https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads | bash

URL="https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/bb-terminal/bb-terminal.sh?ref_type=heads"
ISSUCCESS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $ISSUCCESS -eq 200 ]; then
    curl -s $URL | bash
else
    /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash;
fi
