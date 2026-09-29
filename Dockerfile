FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
	OPENCODE_UPDATE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
	procps ca-certificates curl git git-lfs openssh-client ripgrep jq sudo tzdata unzip make gnupg2 python3 \
	&& rm -rf /var/lib/apt/lists/*

RUN groupmod -g 985 users \
	&& useradd -m -s /bin/bash -g users opencode \
	&& echo "opencode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/opencode \
	&& chmod 0440 /etc/sudoers.d/opencode

USER opencode
ENV PATH="/home/opencode/.opencode/bin:/home/opencode/.local/bin:/usr/local/bin:/usr/bin:/bin"

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /workspace
EXPOSE 4096
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
