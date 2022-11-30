FROM centos:7
ENV container=docker

ENV pip_packages "ansible"

# Install systemd -- See https://hub.docker.com/_/centos/
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /root

RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install requirements.
RUN yum makecache fast \
 && yum -y install deltarpm epel-release initscripts \
 && yum -y update \
 && yum -y install \
      sudo \
      which \
      python3-pip \
      wget \
 && yum clean all

RUN python3 -m pip install --upgrade pip

# Install Ansible via Pip.
RUN pip3 install $pip_packages

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

#RUN wget -P /root --no-check-certificate https://gitlab.cee.redhat.com/jaliang/tw-tam-demolab/-/archive/main/tw-tam-demolab-main.tar.gz \
#&& tar -zxvf tw-tam-demolab-main.tar.gz

ADD . /root/tw-tam-demolab/

RUN wget -P /tmp --no-check-certificate https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/4.10.25/openshift-client-linux.tar.gz \
&& tar -zxvf /tmp/openshift-client-linux.tar.gz \
&& mv -v "/root/oc" /bin/ \ 
&& mv -v "/root/kubectl" /bin 

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
