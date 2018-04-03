# Monika Dockerfile
# Note: This one does not work on OpenShift. Use the xx-osio tagged images instead
# Copyright (c) 2018 Clarity. 
FROM ubuntu:16.04
MAINTAINER Capuccino <chinodesuuu@gmail.com>


# ansible sucks so I'll compile it via this
ADD compile_container.sh /tmp/
RUN chmod a+x /tmp/compile_container.sh
RUN /tmp/compile_container.sh

ADD passwd_template /tmp/
ADD container_run.sh /tmp/
RUN chmod a+x /tmp/container_run.sh

USER 1000
CMD ["/tmp/container_run.sh"]

# cleanup

apt -y remove \
    apt-utils \
    zlib1g-dev \
    build-essential \
    software-properties-common \
    python-software-properties \
    curl \
    wget \
    cmake \
    openssh-server \
    gettext;