FROM node:8

MAINTAINER opuscapita

RUN \
    apt-get update \

    # Install azure-cli
    && apt-get install -y apt-transport-https \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 \
    && apt-get update \
    && apt-get install -y azure-cli \

    # Install httpie, jq
    && apt-get install -y httpie jq \

    # Clean apt cache
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

    # Install Docker locally
    && set -x \
    && VER="17.03.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin \

    # Make CI scripts executable
    && mkdir /ci-scripts \

    # Fix https://github.com/yarnpkg/yarn/issues/2816
    && rm /usr/local/bin/yarn \
    && npm install -g yarn

ADD scripts/* /ci-scripts/

ENTRYPOINT ["/ci-scripts/init.sh"]
