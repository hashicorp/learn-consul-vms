datacenter = "dc1"

data_dir = "/opt/nomad"

bind_addr = "{{ GetInterfaceIP `eth1` }}"

advertise {
  http = "{{ GetInterfaceIP `eth1` }}"
  rpc  = "{{ GetInterfaceIP `eth1` }}"
  serf = "{{ GetInterfaceIP `eth1` }}"
}

client {
  enabled          = true
}
