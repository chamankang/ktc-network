# vim: ft=sh:

@test "quantum user created" {
  ip=`ifconfig eth0 | grep "inet addr" | sed 's/ *inet addr:\([0-9]*.[0-9]*.[0-9]*.[0-9]*\).*/\1/'`
  export OS_SERVICE_ENDPOINT="http://${ip}:35357/v2.0"
  export OS_SERVICE_TOKEN="openstack_identity_bootstrap_token"
  keystone user-password-update --pass admin admin
  keystone user-get quantum
}

@test "heartbeat network created" {
  ip=`ifconfig eth0 | grep "inet addr" | sed 's/ *inet addr:\([0-9]*.[0-9]*.[0-9]*.[0-9]*\).*/\1/'`
  export OS_USERNAME="admin"
  export OS_PASSWORD="admin"
  export OS_TENANT_NAME="admin"
  export OS_AUTH_URL="http://${ip}:5000/v2.0"
  quantum net-show heartbeat
}
