services {
  id   = "frontend"
  name = "frontend"
  tags = [
    "hashicups"
  ]
  address = "$IP_ADDR"
  port    = 80
  checks = [
    {
      id       = "http"
      name     = "HTTP on port 80"
      tcp      = "$IP_ADDR:80"
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
          destination_name   = "public-api"
          local_bind_address = "127.0.0.1"
          local_bind_port    = 8080
          config {
            protocol = "http"
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
