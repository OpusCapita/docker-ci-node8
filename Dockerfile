FROM node:8

MAINTAINER opuscapita

RUN \
    curl -L https://aka.ms/InstallAzureCliBundled -o azure-cli_bundle.tar.gz \
      && tar -xvzf azure-cli_bundle.tar.gz \
      && apt-get update && apt-get install -y libssl-dev libffi-dev python-dev build-essential jq \
      && azure-cli_bundle_*/installer \
      && mv /root/bin/* /usr/local/bin \
      
      && apt-get remove -y --purge libssl-dev libffi-dev python-dev build-essential \
      && rm -rf /root/azure-cli_bundle* \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
      
      && set -x \
      && VER="17.03.0-ce" \
      && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
      && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
      && mv /tmp/docker/* /usr/bin

CMD ["/bin/bash"]
