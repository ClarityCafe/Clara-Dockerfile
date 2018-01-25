#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way
apk update && \
apk upgrade && \
apk add  \
    build-base \
    ffmpeg \
    git \
    sudo \
    python3 \
    openssh-server \
    nodejs \
    gettext
    
# npm install yo?
npm i -g pm2 npm@4 

# Create user
adduser -D -u 1000 user
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

#clone repo, expose Clara as app, then trim contents
mkdir /opt && \
cd /opt && \
git clone https://github.com/ClarityMoe/Clara && \
cd Clara && \
git checkout development && \
mkdir /opt/app && \
mv /opt/Clara/src/* /opt/app && \
mv /opt/Clara/package.json /opt/app && \
rm -rf /opt/Clara && \
cd /opt/app && \
npm i --save --no-prune

# perm root awau
chmod g+rw /opt
chgrp root /opt

# allow to run on openshift
chown -R user:root /opt
chown -R user:root /opt/app
chown -R user:root /opt/app/*
chmod -R g+rw /opt/app
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +
