FROM jenkins/jenkins

COPY plugins.txt /usr/share/jenkins/additional-plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/additional-plugins.txt

COPY ./jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs/jenkins.yaml
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Needed to run the pipelines
USER root
RUN apt-get update && apt-get install -y python3 python3-pip

USER jenkins