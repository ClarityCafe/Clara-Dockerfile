#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way
apk update && \
apk upgrade && \
apk add  \
    build-base \
    bash \
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
addgroup -g 1000 user \
&& adduser -u 1000 -G user -s /bin/sh -D /home/user && \
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

#clone repo, expose Clara as app, then trim contents
mkdir /opt && \
cd /opt && \
git clone https://github.com/ClarityMoe/Clara && \
cd Clara && \
git checkout 0.4.x && \
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
chown -R user:root /opt/app
chown -R user:root /opt/app/*
chmod a+x /opt
chmod -R g+rw /opt/app
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +
