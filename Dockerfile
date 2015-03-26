# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN mkdir /var/run/sshd
RUN mkdir /wordplugins

COPY ./start.sh ./wordinstall.sh ./rpminstall.sh /
COPY ./wordplugins /wordplugins
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf


EXPOSE 80 22

RUN chmod 755 /rpminstall.sh /wordinstall.sh /etc/apache2/foreground.sh /start.sh

RUN /rpminstall.sh
RUN /wordinstall.sh

CMD ["/bin/bash", "/start.sh"]
