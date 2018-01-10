FROM node:8

LABEL maintainer="kirill.volkovich@opuscapita.com"

RUN \
    apt-get update \

    # Install azure-cli
    && apt-get install -y apt-transport-https \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 \
    && apt-get update \
    && apt-get install -y azure-cli=2.0.24-1 \

    # Install httpie, jq
    && apt-get install -y httpie=0.8.0-1 jq=1.4-2.1+deb8u1 \

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

    # Install goss (docker image validation tool) : https://github.com/aelsabbahy/goss
    && curl -L https://github.com/aelsabbahy/goss/releases/download/v0.3.5/goss-linux-amd64 -o /usr/local/bin/goss \
    && chmod +rx /usr/local/bin/goss								 

ADD scripts/* /ci-scripts/

ENTRYPOINT ["/ci-scripts/init.sh"]
