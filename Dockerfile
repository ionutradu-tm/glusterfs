FROM ubuntu:18.04

MAINTAINER Ionut Radu <iradu@iradu.ro>

RUN apt-get update && \
    apt-get install -y software-properties-common
RUN add-apt-repository ppa:gluster/glusterfs-4.1
RUN apt-get update && \
    apt-get install  -y glusterfs-server openssh-server dnsutils


# SSH 
ENV SSH_USER root
ENV SSH_PASS default
ENV EXTERNAL_SSH_PORT 2222
RUN mkdir -p /run/sshd
RUN sed -i 's/^[#]*PermitRootLogin .*/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/^[#]*PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config


# Gluster
ENV GLUSTER_VOL volume
ENV GLUSTER_PATH /mnt/gluster

ENV DEBUG 0


ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh


CMD ["/usr/local/bin/run.sh"]
    

