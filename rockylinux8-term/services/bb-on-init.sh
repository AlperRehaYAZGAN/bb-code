#! /bin/bash

echo "[INFO] OnInit - Script has started." > /tmp/bb-on-init-service.log

# if "INIT_SCRIPT_URL" given, download and run it
if [ -n "$INIT_SCRIPT_URL" ]; then
  echo "[INFO] OnInit - INIT_SCRIPT_URL is downloading... $INIT_SCRIPT_URL" >> /tmp/bb-on-init-service.log
  curl -s $INIT_SCRIPT_URL | bash
  echo "[INFO] OnInit - INIT_SCRIPT_URL completed" >> /tmp/bb-on-init-service.log
fi

echo "[INFO] OnInit - Completed" >> /tmp/bb-on-init-service.log

# in the end create /tmp/ready file to indicate that service is ready
touch /tmp/ready
