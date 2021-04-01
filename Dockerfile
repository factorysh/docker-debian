FROM debian:bullseye-slim

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
            curl \
            locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen \
    && echo "Europe/Paris" > /etc/timezone \
	&& ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
	&& dpkg-reconfigure -f noninteractive tzdata

