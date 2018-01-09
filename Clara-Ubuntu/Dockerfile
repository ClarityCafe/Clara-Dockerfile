# Monika Dockerfile
# Note: This one does not work on OpenShift. Use the xx-osio tagged images instead
# Copyright (c) 2018 Clarity. 
FROM ubuntu:16.04
MAINTAINER Capuccino <chinodesuuu@gmail.com>

ENV DISCORD_TOKEN ""
ENV DEBUG ""
ENV ENABLE_PROMISE_WARNS ""
ENV GAME_NAME ""
ENV GAME_URL ""
ENV BOT_OWNER_ID ""
ENV INSTANCES ""
ENV POEM_HOST ""

# ansible sucks so I'll compile it via this
ADD compile_container.sh /tmp/
RUN chmod a+x /tmp/compile_container.sh
RUN /tmp/compile_container.sh

ADD passwd_template /tmp/
ADD container_run.sh /tmp/
RUN chmod a+x /tmp/container_run.sh

USER 1000
CMD ["/tmp/container_run.sh"]

