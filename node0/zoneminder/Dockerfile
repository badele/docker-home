FROM kylejohnson/zoneminder
MAINTAINER Bruno Adele <bruno@adele.im>

ARG DH_ENV
ARG DH_NODE

ADD tmp/${DH_ENV}/utils/docker/ /ZoneMinder/utils/docker/
RUN chmod 755 /ZoneMinder/utils/docker/setup.sh

# Expose http port
EXPOSE 80

VOLUME /var/lib/zoneminder/images /var/lib/zoneminder/events /var/lib/mysql /var/log/zm

CMD /ZoneMinder/utils/docker/setup.sh && /ZoneMinder/utils/docker/start.sh >/var/log/start.log 2>&1 & /bin/bash
