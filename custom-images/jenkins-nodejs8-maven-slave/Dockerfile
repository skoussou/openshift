FROM openshift/jenkins-slave-base-centos7

####### MAINTAINER ############
MAINTAINER "Red Hat Consulting Team stelios@redhat.com"

####### CHANGE TO ROOT USER ############
USER root

#ENV NODEJS_VERSION=6.x \
#    NPM_CONFIG_PREFIX=$HOME/.npm-global \
#    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
#    BASH_ENV=/usr/local/bin/scl_enable \
#    ENV=/usr/local/bin/scl_enable \
#    PROMPT_COMMAND=". /usr/local/bin/scl_enable"

COPY BINARIES/apache-maven-3.3.9-bin.tar.gz /tmp
COPY BINARIES/nodesource-release-fc27-1.noarch.rpm /tmp
COPY SCRIPTS/.bashrc ~/
#RUN mv ~/bashrc ~/.bashrc

#RUN chown -R 1001:0 $HOME && \
#    chmod -R g+rw $HOME

# Instal MAVEN
#RUN chown 1001:0 ~/.bashrc && \
#    chmod g+rw ~/.bashrc

#RUN /tmp/install-maven.sh

RUN tar xvf /tmp/apache-maven-3.3.9-bin.tar.gz
RUN mv apache-maven-3.3.9  /usr/local/apache-maven
# Add the env variables to your ~/.bashrc file
#RUN export M2_HOME=/usr/local/apache-maven
#RUN export M2=$M2_HOME/bin 
#RUN export PATH=$M2:$PATH
# Execute these commands
RUN source ~/.bashrc


# Install NodeJS
RUN rpm -ihv /tmp/nodesource-release-fc27-1.noarch.rpm
RUN yum install -y nodejs

USER 1001

