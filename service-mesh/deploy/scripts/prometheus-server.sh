#!/usr/bin/env bash

pushd /mnt/my-machine
cp prometheus.service /etc/systemd/system/prometheus.service
mkdir -p /etc/prometheus
popd

# Copy across the config files.
cp /mnt/my-machine/prometheus.yaml /etc/prometheus/prometheus.yaml

# Enable and start the daemons
systemctl enable prometheus
systemctl start prometheus