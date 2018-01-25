#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

su user && \
cd /opt/app && \
/usr/bin/pm2 start /opt/app/pm2.json && \
/usr/bin/pm2 logs Clara
