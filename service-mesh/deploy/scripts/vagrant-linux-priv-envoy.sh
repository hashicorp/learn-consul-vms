#!/usr/bin/env bash

set -o errexit

VERSION="1.16.4"
DOWNLOAD=https://func-e.io/install.sh

function install_envoy() {
	if [[ -e /usr/bin/envoy ]] ; then
		if [ "${VERSION}" == "$(envoy --version | awk '{print $3}' | cut -d/ -f2)" ] ; then
			return
		fi
	fi

	curl -sSL --fail ${DOWNLOAD} | sudo bash -s -- -b /usr/local/bin
	func-e use ${VERSION}
	func-e run --version

	cp ~/.func-e/versions/${VERSION}/bin/envoy /usr/bin/
}

install_envoy
