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
COPY BINARIES/maven-3.3.9-9.fc26.noarch.rpm /tmp

# NODE Installattion
#RUN yum -y install curl
RUN rpm -ihv /tmp/curl-7.53.1-16.fc26.src.rpm
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y install nodejs

#RUN curl --silent https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.9/apache-maven-3.3.9-bin.zip -O -J -L
RUN rpm -ihv /tmp/maven-3.3.9-9.fc26.noarch.rpm

USER 185
