#!/usr/bin/env bash

CONSUL_HTTP_ADDR=${1}
APP_NAME=${2}
APP_IP_ADDR=${3}

pushd /mnt/my-machine
cp consul.service /etc/systemd/system/consul.service
mkdir -p /etc/consul.d
popd

sed 's/$CONSUL_HTTP_ADDR/'"${CONSUL_HTTP_ADDR}"'/g' /mnt/my-machine/consul-client.hcl > /etc/consul.d/consul.hcl
sed 's/$IP_ADDR/'"${APP_IP_ADDR}"'/g' /mnt/my-machine/services/${APP_NAME}.hcl > /etc/consul.d/${APP_NAME}.hcl

cat << EOF > /etc/systemd/system/consul-envoy.service
[Unit]
Description=Consul Envoy
After=syslog.target network.target

[Service]
ExecStart=/usr/bin/consul connect envoy -sidecar-for ${APP_NAME}
ExecStop=/bin/sleep 5
Restart=always

[Install]
WantedBy=multi-user.target
EOF

chmod 644 /etc/systemd/system/consul-envoy.service

systemctl daemon-reload

# Enable and start the daemons
systemctl enable consul
systemctl enable consul-envoy

systemctl start consul
systemctl start consul-envoy
