services {
  id   = "postgres"
  name = "postgres"
  tags = [
    "hashicups"
  ]
  address = "$IP_ADDR"
  port    = 5432
  checks = [
    {
      id       = "tcp"
      name     = "TCP on port 5432"
      tcp      = "$IP_ADDR:5432"
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
