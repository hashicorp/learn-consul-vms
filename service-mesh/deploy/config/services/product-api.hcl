services {
  id   = "product-api"
  name = "product-api"
  tags = [
    "hashicups"
  ]
  address = "$IP_ADDR"
  port    = 9090
  checks = [
    {
      id       = "product-api-http"
      name     = "HTTP on port 9090"
      tcp      = "$IP_ADDR:9090"
      interval = "30s"
      timeout  = "60s"
    }
  ]
  connect {
    sidecar_service {
      port = 20000
      check {
        name     = "Connect Envoy Sidecar"
        tcp      = "$IP_ADDR:20000"
        interval = "10s"
      }
      proxy {
        upstreams {
          destination_name   = "postgres"
          local_bind_address = "127.0.0.1"
          local_bind_port    = 5432
          config {
            protocol = "tcp"
          }
        }
        config {
          protocol                   = "http"
          envoy_prometheus_bind_addr = "0.0.0.0:9102"
        }
      }
    }
  }
}
