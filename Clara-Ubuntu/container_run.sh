#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

/usr/bin/pm2 start /opt/app/bot.js -e /home/user/.clara/err.log -o /home/user/.clara/out.log && \
/usr/bin/pm2 logs bot
