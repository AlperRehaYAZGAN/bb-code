#! /bin/bash

# set terminal and bash defaults
export TERM=xterm-256color

# set workspace
cd /root/workspace

# start terminal
while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done