#!/usr/bin/env bash

pushd /mnt/my-machine
cp consul.service /etc/systemd/system/consul.service
mkdir -p /etc/consul.d
popd

sed 's/$CONSUL_HTTP_ADDR/'"${1}"'/g' /mnt/my-machine/consul-client.hcl > /etc/consul.d/consul.hcl

# Enable and start the daemons
systemctl enable consul
systemctl start consul