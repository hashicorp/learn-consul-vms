data_dir = "/tmp/consul/server"

server           = true
bootstrap_expect = 1
advertise_addr   = "{{ GetInterfaceIP `eth1` }}"
client_addr      = "0.0.0.0"
bind_addr        = "0.0.0.0"

ui_config {
  enabled          = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://localhost:9090"
  }
}

datacenter = "dc1"

telemetry {
  prometheus_retention_time = "24h"
  disable_hostname          = true
}
