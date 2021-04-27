#!/usr/bin/env bash

apt-get update
apt-get install -y nginx

pushd /mnt/my-machine
cp -r frontend/. /usr/share/nginx/html/
cp default.conf /etc/nginx/conf.d/default.conf
popd

# Enable and start the daemons
systemctl enable nginx
systemctl restart nginx

