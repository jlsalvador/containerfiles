FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
	BUN_INSTALL=/usr/local
ENV PATH="${BUN_INSTALL}/bin:/home/opencode/.bun/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
	procps ca-certificates curl git git-lfs openssh-client ripgrep jq sudo tzdata unzip make \
	&& rm -rf /var/lib/apt/lists/*

RUN groupmod -g 985 users \
	&& useradd -m -s /bin/bash -g users opencode \
	&& echo "opencode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/opencode \
	&& chmod 0440 /etc/sudoers.d/opencode

USER opencode
ENV BUN_INSTALL=/home/opencode/.bun
ENV PATH="/home/opencode/.bun/bin:/usr/local/bin:${PATH}"
RUN curl -fsSL https://bun.sh/install | bash \
	&& bun --version \
	&& bun install -g --trust @opencode/cli@2 \
	&& opencode2 --version
RUN mkdir -p /home/opencode/.bun/bin /home/opencode/.cache
WORKDIR /workspace
EXPOSE 4096
CMD ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "4096"]
