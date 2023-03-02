FROM debian:9
LABEL maintainer="lotusnoir"

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo systemd systemd-sysv build-essential wget libffi-dev libssl-dev python-pip python-dev python-setuptools python-wheel python-apt iproute2 net-tools procps ca-certificates \
    && python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir ansible cryptography jmespath \
    && apt-get clean \
    && wget -q -O /usr/local/bin/goss https://github.com/aelsabbahy/goss/releases/download/v0.3.21/goss-linux-amd64 && chmod +x /usr/local/bin/goss \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc /usr/share/man \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/sys/fs/cgroup", "/tmp" ]
ENTRYPOINT ["/lib/systemd/systemd"]
