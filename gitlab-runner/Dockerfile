FROM gitlab/gitlab-runner

# Dependency for builds
RUN apt-get update && apt-get install -y python3 python3-pip jq docker.io

# Giving gitlab-runner access to the docker.sock.
RUN chgrp docker /var/run/docker.sock && usermod -aG docker gitlab-runner

# Preinstall custom aarch64 version (2.3.0) of mayhem 
COPY mayhem-aarch64 /usr/local/bin