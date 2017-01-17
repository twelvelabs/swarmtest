FROM jenkins:2.32.1

# Allow jenkins to run docker
USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers


USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy

RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/ref/plugins.txt
