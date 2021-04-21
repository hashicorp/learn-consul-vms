#!/usr/bin/env bash

PROMETHEUS_IP_ADDR=${1}

pushd /mnt/my-machine
cp consul.service /etc/systemd/system/consul.service
mkdir -p /etc/consul.d
popd

# Copy across the config files.
cp /mnt/my-machine/consul-server.hcl /etc/consul.d/consul.hcl
sed -i 's/$PROMETHEUS_IP_ADDR/'"${PROMETHEUS_IP_ADDR}"'/g' /etc/consul.d/consul.hcl

# Enable and start the daemons
systemctl enable consul
systemctl start consul
