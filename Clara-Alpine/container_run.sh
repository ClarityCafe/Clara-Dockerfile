#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

cd /opt/app && \
pm2 start pm2.json && \
pm2 logs Clara
