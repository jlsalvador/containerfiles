IMG ?= docker.io/jlsalvador/opencode
PLATFORMS ?= linux/arm64,linux/amd64
NO_CACHE ?=
ifeq ($(strip $(NO_CACHE)),1)
NO_CACHE_FLAG := --no-cache
endif

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
		$(NO_CACHE_FLAG) \
		--manifest ${IMG} \
		-f Dockerfile \
		.

.PHONY: publish
publish: build
	podman manifest push ${IMG}
