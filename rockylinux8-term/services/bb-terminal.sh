#! /bin/bash

# set terminal and bash defaults
export TERM=xterm-256color

# set working directory /root/workspace
# cd /root/workspace
export $(grep -v '^#' /tmp/env/image.env | xargs)
export $(grep -v '^#' /tmp/env/bb.env | xargs)

# start terminal with nohup
nohup /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash