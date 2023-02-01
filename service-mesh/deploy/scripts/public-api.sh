#!/usr/bin/env bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


set -o errexit

pushd /mnt/my-machine
cp public-api.service /etc/systemd/system/public-api.service
popd

VERSION="0.0.4"
DOWNLOAD=https://github.com/hashicorp-demoapp/public-api/releases/download/v${VERSION}/public-api

function install_app() {
	curl -sSL --fail -o /tmp/public-api ${DOWNLOAD}

	mv /tmp/public-api /usr/bin/public-api
	chmod +x /usr/bin/public-api
}

install_app

systemctl daemon-reload
systemctl enable public-api
systemctl start public-api