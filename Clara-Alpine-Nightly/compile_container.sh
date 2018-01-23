#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way
apk install  \
    build-base \
    ffmpeg \
    git \
    sudo \
    python3 \
    openssh-server \

# npm install yo?
npm i -g pm2 npm@4 

# Create user
mkdir /var/run/sshd && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
usermod -p "*" user 

#clone repo, expose Clara as app, then trim contents
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
chown -R user:root /opt/app
chown -R user:root /opt/app/*
chown -R user:root /.pm2
chmod -R g+rw /opt/app
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +
