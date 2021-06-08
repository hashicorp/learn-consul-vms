#!/usr/bin/env bash

set -o errexit

VERSION="1.16.4"
DOWNLOAD=https://getenvoy.io/cli

function install_envoy() {
	if [[ -e /usr/bin/envoy ]] ; then
		if [ "${VERSION}" == "$(envoy --version | awk '{print $3}' | cut -d/ -f2)" ] ; then
			return
		fi
	fi

	curl -sSL --fail ${DOWNLOAD} | sudo bash -s -- -b /usr/local/bin
	getenvoy use $${ENVOY_VERSION}
	getenvoy run --version

	cp ~/.getenvoy/builds/standard/${VERSION}/linux_glibc/bin/envoy /usr/bin/
}

install_envoy
