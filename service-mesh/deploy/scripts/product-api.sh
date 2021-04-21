#!/usr/bin/env bash

set -o errexit

pushd /mnt/my-machine
cp product-api.service /etc/systemd/system/product-api.service
mkdir -p /etc/product-api.d
cp conf.json /etc/product-api.d/conf.json
popd

VERSION="0.0.15"
DOWNLOAD=https://github.com/hashicorp-demoapp/product-api-go/releases/download/v${VERSION}/product-api

function install_app() {
	curl -sSL --fail -o /tmp/product-api ${DOWNLOAD}

	mv /tmp/product-api /usr/bin/product-api
	chmod +x /usr/bin/product-api
}

install_app

systemctl daemon-reload
systemctl enable product-api
systemctl start product-api