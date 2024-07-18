#!/bin/bash

export PS1='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[00m\] $ '
alias poweroff='kill -1 1'

[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd
