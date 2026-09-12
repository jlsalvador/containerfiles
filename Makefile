IMG ?= docker.io/jlsalvador/opencode
PLATFORMS ?= linux/arm64,linux/amd64

.PHONY: build
build:
	podman \
		manifest rm -i \
		${IMG}
	podman \
		manifest create \
		${IMG}
	podman \
		build \
		--platform=$(PLATFORMS) \
		--manifest ${IMG} \
		-f Dockerfile \
		.

.PHONY: publish
publish: build
	podman manifest push ${IMG}
