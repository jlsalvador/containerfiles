#!/bin/bash
set -uo pipefail

# The image ships no opencode: the entrypoint installs it, then execs it.
#   VERSION unset/empty (default) = latest, or pin it: VERSION=2.0.19
#   OPENCODE_UPDATE=0 = skip the install and run whatever $HOME/.opencode/bin already has

if [ "${OPENCODE_UPDATE:-1}" = 1 ]; then
	# Same version source the installer itself uses: one 346 B GET instead of an 89 MB download.
	want="${VERSION:-$(curl -fsSL https://opencode.ai/update/api/latest/cli/npm | jq -r .version)}"
	have=$(opencode --version 2>/dev/null | awk '{print $NF}')
	have="${have#v}"
	[ "$have" = "${want#v}" ] ||
		curl -fsSL https://opencode.ai/v2/install | env VERSION="$want" bash -s -- --no-modify-path
fi

[ $# -gt 0 ] && exec opencode "$@"
exec opencode serve --hostname 0.0.0.0 --port 4096
