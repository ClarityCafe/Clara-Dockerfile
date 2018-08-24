#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export NODE_OPTIONS="max_old_space_size=256"
envsubst < /tmp/passwd_template > /tmp/passwd

cd /opt/app && \
/usr/bin/pm2 start /opt/app/pm2.json && \
/usr/bin/pm2 logs Clara
