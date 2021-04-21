#!/usr/bin/env bash

set -o errexit

VERSION="2.26.0"
DOWNLOAD=https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz

function install_prometheus() {
	if [[ -e /usr/bin/prometheus ]] ; then
		return
	fi

	cd /tmp
	curl -sSL --fail -o prometheus-${VERSION}.linux-amd64.tar.gz ${DOWNLOAD}

	tar xvf prometheus-${VERSION}.linux-amd64.tar.gz
	mv prometheus-${VERSION}.linux-amd64/prometheus /usr/bin/prometheus
	chmod +x /usr/bin/prometheus
}

install_prometheus
