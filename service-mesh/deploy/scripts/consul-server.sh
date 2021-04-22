#!/usr/bin/env bash

pushd /mnt/my-machine
cp consul.service /etc/systemd/system/consul.service
mkdir -p /etc/consul.d
popd

# Copy across the config files.
cp /mnt/my-machine/consul-server.hcl /etc/consul.d/consul.hcl

# Enable and start the daemons
systemctl enable consul
systemctl start consul

until consul members; do
    echo "Waiting for Consul to start"
    sleep 1
done

consul config write /mnt/my-machine/service-defaults/proxy-defaults.hcl