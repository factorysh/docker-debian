build: | bullseye bullseye-dev

bullseye:
	docker build -t bearstech/debian:bullseye .
	docker tag bearstech/debian:bullseye bearstech/debian:11

bullseye-dev:
	docker build \
		-t bearstech/debian-dev:bullseye \
		-f Dockerfile.dev \
	.
	docker tag bearstech/debian-dev:bullseye bearstech/debian-dev:11

pull:
	docker pull debian:bullseye-slim

tests:
	echo "TODO"

push:
	echo "TODO"
