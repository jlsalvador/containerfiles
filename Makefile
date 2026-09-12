IMG ?= docker.io/jlsalvador/opencode
PLATFORMS ?= linux/arm64,linux/amd64

.PHONY: build
build:
	podman rmi -f ${IMG} || true
	podman manifest rm -i ${IMG} || true
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
