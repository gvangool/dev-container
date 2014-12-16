FROM centos:centos7
MAINTAINER Gert Van Gool <gert@vangool.mx>

# Default stuff
RUN yum install -y zsh tar wget vim git && yum clean all
# sudo, because sometimes you want to install stuff
RUN yum install -y sudo && yum clean all
# Databases librariers
RUN yum install -y mariadb postgresql && yum clean all
# Python setup
RUN yum install -y python python-{devel,setuptools,imaging} && \
    yum clean all && \
    easy_install pip

RUN groupadd --gid 1003 gert && adduser --uid 1001 -g gert gert
USER gert
WORKDIR /home/gert
RUN mkdir -p src && cd src && \
    git clone git://github.com/gvangool/dotfiles.git && \
    cp -r dotfiles/.git /home/gert && \
    cd /home/gert && \
    git reset --hard && git submodule update --init --recursive

CMD "zsh"
