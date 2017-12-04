FROM node:8

MAINTAINER opuscapita

RUN \
    apt-get update && apt-get install -y libssl-dev libffi-dev python-dev build-essential \
    && curl -L https://aka.ms/InstallAzureCli | bash

CMD ["/bin/bash"]
