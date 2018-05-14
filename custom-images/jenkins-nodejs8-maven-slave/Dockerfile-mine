FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

####### MAINTAINER ############
MAINTAINER "Red Hat Consulting Team" "stelios@redhat.com"

####### BASE SOFTWARE ############
# HTTP daemon
# # RUN yum install -y httpd; \ 
# yum clean all

####### CHANGE TO ROOT USER ############
USER root

############ Add custom repo files ############
#COPY CUSTOM_REPOS/fedora.repo /etc/yum.repos.d/
#COPY CUSTOM_REPOS/fedora-updates.repo /etc/yum.repos.d/
#COPY CUSTOM_REPOS/fedora-updates-testing.repo /etc/yum.repos.d/
#COPY CUSTOM_REPOS/fedora-cisco-openh264.repo /etc/yum.repos.d/
#COPY CUSTOM_REPOS/nodesource-fc26.repo /etc/yum.repos.d/

COPY BINARIES/curl-7.53.1-16.fc26.src.rpm /tmp
COPY BINARIES/apache-maven-3.3.9-bin.tar.gz /tmp

# NODE Installattion
#RUN yum -y install curl
RUN rpm -ihv /tmp/curl-7.53.1-16.fc26.src.rpm
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs

# MAVEN Installation
#RUN yum -y install maven
#RUN curl --silent https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.9/apache-maven-3.3.9-bin.zip -O -J -L
#RUN rpm -ihv /tmp/maven-3.3.9-9.fc26.noarch.rpm
#RUN yum install -y maven

RUN tar xvf /tmp/apache-maven-3.3.9-bin.tar.gz
RUN mv apache-maven-3.3.9  /usr/local/apache-maven
# Add the env variables to your ~/.bashrc file
RUN export M2_HOME=/usr/local/apache-maven
RUN export M2=$M2_HOME/bin 
RUN export PATH=$M2:$PATH
# Execute these commands
RUN source ~/.bashrc

USER 185
