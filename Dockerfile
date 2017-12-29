FROM jenkins/jenkins

USER root

RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN curl -sSL https://get.docker.com/ | sh
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN usermod -aG docker jenkins
RUN service docker restart
USER jenkins

COPY plugins.txt /var/jenkins_home/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /var/jenkins_home/plugins.txt
