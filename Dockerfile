FROM node:8

MAINTAINER opuscapita

RUN \
    apt-get update && apt-get -y install apt-transport-https \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 \
    && apt-get update && sudo apt-get -y install azure-cli

CMD ["/bin/bash"]
