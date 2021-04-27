data_dir = "/tmp/consul/server"

server           = true
bootstrap_expect = 1
advertise_addr   = "{{ GetInterfaceIP `eth1` }}"
client_addr      = "0.0.0.0"
bind_addr        = "0.0.0.0"

ports {
  grpc = 8502
}

enable_central_service_config = true

ui_config {
  enabled          = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://$PROMETHEUS_IP_ADDR:9090"
  }
}

connect {
  enabled = true
}

datacenter = "dc1"

telemetry {
  prometheus_retention_time = "24h"
  disable_hostname          = true
}

config_entries {
  bootstrap = [
    {
      kind = "proxy-defaults"
      name = "global"
      config {
        protocol                   = "http"
        envoy_prometheus_bind_addr = "0.0.0.0:9102"
      }
    }
  ]
}