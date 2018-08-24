#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way

echo " >>>>>>>>>>>>>>>> INSTALL DEPS"

apt update && \
apt install -y \
    apt-utils \
    zlib1g-dev \
    sudo \
    build-essential \
    software-properties-common \
    python-software-properties \
    ffmpeg \
    curl \
    wget \
    gcc \
    clang \
    git \
    tar \
    cmake \
    openssh-server \
    gettext  \

echo "<<<<<<<<<<<<<<<<<<<<<<<<<< INSTALL DEPS"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>> INSTALL NODE"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
sudo apt -y install nodejs
echo "<<<<<<<<<<<<<<<<<<<<<<<<<< INSTALL NODE"
# npm install yo?
npm i -g pm2  && \
mkdir /.pm2
mkdir /.npm
echo ">>>>>>>>>>>>>>>>>>>>>  CREATE USER"
# Create user
mkdir /var/run/sshd && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
usermod -p "*" user 
echo "<<<<<<<<<<<<<<<<<<<<<<  CREATE USER"

echo ">>>>>>>>>>>>>>>>>>>>>> INSTALL CLARA"
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
npm i --save && \
npm run circle-postinstall

echo "<<<<<<<<<<<<<<<<<<<<<<<< INSTALL CLARA"

echo ">>>>>>>>>>>>>>>>>>>>>>>> OPENSHIFT OVERRIDES"
# perm root awau
chmod g+rw /opt
chgrp root /opt

# allow to run on openshift
chown -R user:root /opt/app
chown -R user:root /opt/app/*
chown -R user:root /.pm2
chmod -R g+rw /.pm2
chmod -R g+rw /.npm
chmod -R g+rw /opt/app
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +
echo 'done'

echo "<<<<<<<<<<<<<<<<<<<<<<<<< OPENSHIFT OVERRIDES"
# cleanup
echo ">>>>>>>>>>>>>>>>>>>>>>>> CLEANUP"
apt -y remove \
    zlib1g-dev \
    build-essential \
    software-properties-common \
    python-software-properties \
    cmake \
    openssh-server \
echo "<<<<<<<<<<<<<<<<<<<<<<<< CLEANUP"