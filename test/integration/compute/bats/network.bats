# vim: ft=sh:

@test "quantum-dhcp-agent is running" {
  ps aux | grep [q]uantum-dhcp-agent
}

@test "quantum-linuxbridge-agent is running" {
  ps aux | grep [q]uantum-linuxbridge-agent
}

@test "quantum-metadata-agent is running" {
  ps aux | grep [q]uantum-metadata-agent
}
