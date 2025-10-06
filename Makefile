IMG ?= docker.io/jlsalvador/torproxy
PLATFORMS ?= linux/arm64,linux/amd64

.PHONY: build
build:
	podman \
		build \
		--platform=$(PLATFORMS) \
		--tag ${IMG} \
		-f Dockerfile \
		.

.PHONY: publish
publish: build
	podman push ${IMG}
