FROM scratch

MAINTAINER The CentOS Project <cloud-ops@centos.org>

ADD c7-docker.tar.xz /

LABEL Vendor="CentOS"
LABEL License=GPLv2

# Volumes for systemd
# VOLUME ["/run", "/tmp"]

# Environment for systemd
# ENV container=docker

# For systemd usage this changes to /usr/sbin/init
# Keeping it as /bin/bash for compatability with previous

CMD ["/bin/bash"]

