FROM gitlab/gitlab-runner

# Dependency for builds
RUN apt-get update && apt-get install -y python3 python3-pip jq docker.io

RUN usermod -aG docker gitlab-runner

# Preinstall custom aarch64 version (2.3.0) of mayhem 
RUN curl -sL -o /usr/local/bin/mayhem-aarch64 'https://drive.google.com/uc?export=download&id=1pkooWxN5MBSTmvigzLi9Q_wgD-pBSjue'
RUN chmod a+rx /usr/local/bin/mayhem-aarch64
