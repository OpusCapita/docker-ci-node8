FROM node:8

MAINTAINER opuscapita

RUN \
    apt-get update && apt-get install apt-transport-https \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
    && apt-get update && apt-get install azure-cli

CMD ["/bin/bash"]
