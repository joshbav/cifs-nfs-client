# This container is built with the --squash option, so there's no need
# to pack many bash lines into one big one

FROM centos:7

ENV TERM xterm

RUN yum update -y
RUN yum install epel-release -y

# required for CIFS
RUN yum install -y cifs-utils
# Make the CIFS mountpoint
RUN mkdir /cifs

# required for NFS
RUN yum install -y nfs-utils 
# Make the NFS mountpoint
RUN mkdir /nfs

# Utilities Josh tends to use, not required
RUN yum install -y \ 
yum-tools \
which \
autofs \
deltarpm \
ca-certificates \
man \
nano \
less \
expect \
curl \
wget \
ftp \
jq \
openssh-clients \
net-tools \
traceroute \
tcping \
iproute \
bind-utils \
unzip \
zip \
bzip2

# Default to UTF-8 file.encoding
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

