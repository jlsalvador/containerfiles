IMG ?= jlsalvador/remotedesktop
PLATFORMS ?= linux/arm64,linux/amd64

.PHONY: publish
publish:
	docker buildx \
		build \
		--push \
		--platform=$(PLATFORMS) \
		--tag ${IMG} \
		-f Dockerfile \
		.
