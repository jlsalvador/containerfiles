IMG ?= jlsalvador/curl-jq
PLATFORMS ?= linux/arm64,linux/amd64,linux/s390x,linux/ppc64le

.PHONY: publish
publish:
	docker buildx \
		build \
		--push \
		--platform=$(PLATFORMS) \
		--tag ${IMG} \
		-f Dockerfile \
		.
