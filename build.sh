#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

# Install required utils
apt-get update
apt-get install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
	curl \
	git \
	make

# Download recent release of jq
curl -sSfLo /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod 0755 /usr/local/bin/jq

# Download latest release of inner-runner
DOWNLOAD=$(curl -sSfL https://api.github.com/repos/repo-runner/repo-runner/releases/latest |
	jq -r '.assets | .[] | select(.name == "inner-runner_linux_amd64.tar.gz") | .browser_download_url')
curl -sSfL "${DOWNLOAD}" | tar -xzf - -C /usr/local/bin
mv /usr/local/bin/inner-runner* /usr/local/bin/inner-runner

# Cleanup
apt-get autoremove --purge -y
rm -rf /var/lib/apt/lists/*
