FROM jenkins/jenkins:lts
USER root
RUN apt-get update
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update
RUN apt-get install -y docker-ce
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
RUN apt-get install apt-transport-https
RUN apt-get update && apt-get install -y azure-cli
RUN curl -sSL https://cli.openfaas.com | sh

# Jenkins > openjdk > buld-debs > debian:stretch
# https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-repository
# docker build -t myjenk .
# docker run -itd -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /home/tdr/tmp/jenkins/jenkins_home:/var/jenkins_home --name jenkins myjenk
# docker service create -p 8081:8080 -p 50000:50000 \
#  --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock \
#  --mount type=bind,source=/home/tdr/jenkins/jenkins_home,destination=/var/jenkins_home \
#  --name jenkins tripdubroot/jenkins:latest
# docker service update --image tripdubroot/jenkins:latest jenkins