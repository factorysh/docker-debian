include Makefile.lint
include Makefile.build_args

GOSS_VERSION := 0.3.16

build: images

images: | bullseye bullseye-dev

pull:
	docker pull debian:bullseye-slim

push:
	docker push bearstech/debian:bullseye
	docker push bearstech/debian:11
	docker push bearstech/debian-dev:bullseye
	docker push bearstech/debian-dev:11

bullseye:
	docker build \
		$(DOCKER_BUILD_ARGS) \
		-t bearstech/debian:bullseye .
	docker tag bearstech/debian:bullseye bearstech/debian:11

bullseye-dev:
	docker build \
		$(DOCKER_BUILD_ARGS) \
		-t bearstech/debian-dev:bullseye \
		-f Dockerfile.dev \
	.
	docker tag bearstech/debian-dev:bullseye bearstech/debian-dev:11

bin/goss-${GOSS_VERSION}:
	mkdir -p bin
	curl -o bin/goss-${GOSS_VERSION} -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x bin/goss-${GOSS_VERSION}
	cd bin && ln -sf goss-${GOSS_VERSION} goss

build: bullseye bullseye-dev

tests: test-debian

test-debian: bin/goss-${GOSS_VERSION}
	@docker run --rm -t \
		-v `pwd`/bin/goss:/usr/local/bin/goss \
		-v `pwd`/tests:/goss \
		-w /goss \
		bearstech/debian:bullseye \
		goss -g debian.yaml validate --max-concurrent 4 --format documentation

test-dev: bin/goss-${GOSS_VERSION}
	@docker run --rm -t \
		-v `pwd`/bin/goss:/usr/local/bin/goss \
		-v `pwd`/tests:/goss \
		-w /goss \
		bearstech/debian-dev:bullseye \
		goss -g dev-all.yaml validate --max-concurrent 4 --format documentation

down:
	@echo "Nothing to do."

