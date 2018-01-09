#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

/usr/bin/pm2 start /opt/app/bot.js && \
/usr/bin/pm2 logs bot
