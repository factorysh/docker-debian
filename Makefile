include Makefile.lint

GOSS_VERSION := 0.3.16

build: images

images: | bullseye bullseye-dev

pull:
	docker pull debian:bullseye-slim

bullseye:
	docker build -t bearstech/debian:bullseye .
	docker tag bearstech/debian:bullseye bearstech/debian:11

bullseye-dev:
	docker build \
		-t bearstech/debian-dev:bullseye \
		-f Dockerfile.dev \
	.
	docker tag bearstech/debian-dev:bullseye bearstech/debian-dev:11

push:
	echo "TODO"

bin/goss:
	mkdir -p bin
	curl -o bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x bin/goss

tests: bin/goss
	echo "TODO"

