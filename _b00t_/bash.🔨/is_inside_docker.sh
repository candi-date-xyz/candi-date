#!/bin/bash

# returns 0 (success) if docker
#           1 if not docker, require sudo

# detect based on ./dockerenv file
# https://www.baeldung.com/linux/is-process-running-inside-container

#echo $?

# cat /proc/1/sched | head -n 1
#   will be init or systemd (not docker)
#   will be bash for docker

if [ -f /.dockerenv ] ; then
    log_📢_记录 "🐳😉."
#else if [ "$IS_DOCKER" -gt 0 ] ; then
#else if [ -v $IS_DOCKER ] ; then
    exit 0
else if [  `cat /proc/1/sched | head -n 1 | grep -c "bash"` ] ; then
    # bash, means docker
    exit 0
else 
    log_📢_记录 "🐳🚫 not docker, need sudo"
    exit 1
fi

