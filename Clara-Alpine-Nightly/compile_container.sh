#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way
apk update && \
apk upgrade && \
apk add  \
    bash \
    ffmpeg \
    build-base \
    python \
    git \
    sudo \
    gettext
    
# npm install yo?
npm i -g pm2 npm@4 

# Create user
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

#clone repo, expose Clara as app, then trim contents
chmod a+x /opt && \
cd /opt && \
git clone https://github.com/ClarityMoe/Clara && \
cd Clara && \
mkdir /opt/app && \
mv /opt/Clara/src/* /opt/app && \
mv /opt/Clara/package.json /opt/app && \
rm -rf /opt/Clara && \
cd /opt/app && \
npm i --save 

# perm root awau
chmod g+rw /opt
chgrp root /opt

# allow to run on openshift
mkdir /.pm2 && \
mkdir /.npm && \
chown -R node:root /.npm
chown -R node:root /.pm2
chown -R node:root /opt/app
chown -R node:root /opt/app/*
chmod -R g+rw /.npm
chmod -R g+rw /.pm2
chmod -R g+rw /opt/app
chmod -R g+rw /home/node
find /home/node -type d -exec chmod g+x {} +

# clean up uneeded stuff
apk del \
   build-base \
   git;