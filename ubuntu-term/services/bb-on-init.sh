#! /bin/bash

# start terminal
echo "[INFO] OnInit - Starting Terminal" > /tmp/bb-on-init-service.log
echo "[INFO] OnInit - bb-terminal service starting..." >> /tmp/bb-on-init-service.log

# run bare script from env "INIT_SCRIPT"
if [ -n "$INIT_SCRIPT" ]; then
    echo "[INFO] OnInit - Running INIT_SCRIPT" >> /tmp/bb-on-init-service.log
    echo "[INFO] OnInit - Running $INIT_SCRIPT" >> /tmp/bb-on-init-service.log
    bash -c "$INIT_SCRIPT"
    echo "[INFO] OnInit - Completed" >> /tmp/bb-on-init-service.log
fi

echo "[INFO] OnInit - Completed" >> /tmp/bb-on-init-service.log
