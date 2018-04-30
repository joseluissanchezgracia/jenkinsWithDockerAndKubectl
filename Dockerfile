FROM jenkins/jenkins:lts

EXPOSE 8080 50000
USER root

# Install prerequisites for Docker
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

RUN apt-get update && apt-get install -y docker-ce

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.7/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Configure access to the Kubernetes Cluster
ADD install/config ~/.kube

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]