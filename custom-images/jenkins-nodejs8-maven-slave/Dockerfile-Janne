FROM openshift/jenkins-slave-base-centos7

####### MAINTAINER ############
MAINTAINER "Red Hat Consulting Team" "stelios@redhat.com"

####### CHANGE TO ROOT USER ############
USER root

ENV NODEJS_VERSION=6.x \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"

COPY contrib/bin/scl_enable /usr/local/bin/scl_enable

# Install chrome
COPY google-chrome.repo /etc/yum.repos.d/
RUN yum install -y google-chrome-stable && \
    yum clean all -y

# Install NodeJS
RUN yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="rh-nodejs6 rh-nodejs6-npm rh-nodejs6-nodejs-nodemon" && \
    ln -s /usr/lib/node_modules/nodemon/bin/nodemon.js /usr/bin/nodemon && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y


RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME


COPY BINARIES/apache-maven-3.3.9-bin.tar.gz /tmp
RUN mv apache-maven-3.3.9  /usr/local/apache-maven
# Add the env variables to your ~/.bashrc file
RUN export M2_HOME=/usr/local/apache-maven
RUN export M2=$M2_HOME/bin 
RUN export PATH=$M2:$PATH
# Execute these commands
RUN source ~/.bashrc

USER 1001
