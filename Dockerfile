FROM debian:bullseye-slim

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
            curl \
            locales \
            vim-tiny \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY bearstech-archive.gpg /etc/apt/trusted.gpg.d/bearstech-archive.gpg

RUN printf "en_US.UTF-8 UTF-8\nfr_FR.UTF-8 UTF-8\n" > /etc/locale.gen \
    && printf "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen \
    && echo "Europe/Paris" > /etc/timezone \
    && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata
    #&& echo "deb http://deb.bearstech.com/debian bullseye-bearstech main" > /etc/apt/sources.list.d/bullseye-bearstech.list \

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL \
    com.bearstech.image.revision_date=${GIT_DATE} \
    org.opencontainers.image.authors=Bearstech \
    org.opencontainers.image.revision=${GIT_VERSION} \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.url=https://github.com/factorysh/docker-debian \
    org.opencontainers.image.source=https://github.com/factorysh/docker-debian/blob/${GIT_VERSION}/Dockerfile
