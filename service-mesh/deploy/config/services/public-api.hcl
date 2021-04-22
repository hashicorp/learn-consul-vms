services {
  id   = "public-api"
  name = "public-api"
  tags = [
    "hashicups"
  ]
  address = "$IP_ADDR"
  port    = 8080
  checks = [
    {
      id       = "http"
      name     = "HTTP on port 8080"
      tcp      = "$IP_ADDR:8080"
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
      proxy {}
    }
  }
}
