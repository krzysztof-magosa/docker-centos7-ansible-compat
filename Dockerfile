FROM centos:8

MAINTAINER Krzysztof Magosa <krzysztof@magosa.pl>

RUN \
  yum makecache fast && \
  yum install -y python sudo yum-plugin-ovl bash && \
  sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && \
  yum clean all; \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*; \
  rm -f /etc/systemd/system/*.wants/*; \
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*; \
  rm -f /lib/systemd/system/anaconda.target.wants/*

CMD ["/sbin/init"]
