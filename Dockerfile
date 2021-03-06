FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND="noninteractive"

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
            curl \
            locales \
            vim-tiny \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN printf "en_US.UTF-8 UTF-8\nfr_FR.UTF-8 UTF-8\n" > /etc/locale.gen \
    && printf "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen \
    && echo "Europe/Paris" > /etc/timezone \
    && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

ENV LANG="en_US.UTF-8"

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL \
    com.bearstech.image.debian.created=${GIT_DATE} \
    com.bearstech.image.debian.revision=${GIT_VERSION} \
    com.bearstech.image.debian.version=11 \
    org.opencontainers.image.authors=Bearstech \
    org.opencontainers.image.revision=${GIT_VERSION} \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.url=https://github.com/factorysh/docker-debian \
    org.opencontainers.image.source=https://github.com/factorysh/docker-debian/blob/${GIT_VERSION}/Dockerfile
