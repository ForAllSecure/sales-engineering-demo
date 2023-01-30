FROM jenkins/jenkins

COPY plugins.txt /usr/share/jenkins/additional-plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/additional-plugins.txt

COPY ./jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs/jenkins.yaml
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Needed to run the pipelines
USER root
RUN apt-get update && apt-get install -y python3 python3-pip jq docker.io

# Preinstall custom aarch64 version (2.3.0) of mayhem 
RUN curl --no-progress-meter -Lo /usr/local/bin/mayhem-aarch64 'https://drive.google.com/uc?export=download&id=1pkooWxN5MBSTmvigzLi9Q_wgD-pBSjue'
RUN chmod a+rx /usr/local/bin/mayhem-aarch64

USER jenkins