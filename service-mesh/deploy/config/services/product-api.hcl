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
        config {
          protocol                   = "http"
          envoy_prometheus_bind_addr = "0.0.0.0:9102"
        }
      }
    }
  }
}
