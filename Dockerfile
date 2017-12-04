FROM node:8

MAINTAINER opuscapita

RUN \
    curl -L https://aka.ms/InstallAzureCliBundled -o azure-cli_bundle.tar.gz \
      && tar -xvzf azure-cli_bundle.tar.gz \
      && apt-get update && apt-get install -y libssl-dev libffi-dev python-dev build-essential \
      && azure-cli_bundle_*/installer \
      && echo "export PATH=$PATH:/root/bin" > /root/.bashrc \
      && apt-get remove --purge libssl-dev libffi-dev python-dev build-essential
      && rm -rf /root/azure-cli_bundle* \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

CMD ["/bin/bash"]
