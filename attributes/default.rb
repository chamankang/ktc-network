#
## Cookbook Name:: quantum
## Attributes:: default
##
## Copyright 2012, Rackspace US, Inc.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

include_attribute 'openstack-network::default'

default['openstack']['network']['api']['agent']['agent_report_interval'] = 4
default['openstack']['network']['rabbit_server_chef_role'] = 'ktc-messaging'
default['openstack']['network']['core_plugin'] = 'quantum.plugins.linuxbridge.lb_quantum_plugin.LinuxBridgePluginV2'
default['openstack']['network']['interface_driver'] = 'quantum.agent.linux.interface.BridgeInterfaceDriver'
default['openstack']['network']['use_namespaces'] = 'False'
default['openstack']['network']['enable_multi_host'] = 'True'
default['openstack']['network']['l3']['external_network_bridge'] = ''
default['openstack']['network']['dhcp']['enable_isolated_metadata'] = 'True'
default['openstack']['network']['linuxbridge']['sqlalchemy_pool_size'] = 20
default['openstack']['network']['linuxbridge']['sqlalchemy_max_overflow'] = 50
default['openstack']['network']['linuxbridge']['sqlalchemy_pool_timeout'] = 30
default['openstack']['network']['quota_security_group'] = 100
default['openstack']['network']['platform']['quantum_linuxbridge_agent_service'] = 'quantum-plugin-linuxbridge-agent'
default['openstack']['network']['platform']['mysql_python_packages'] = []
default['openstack']['network']['platform']['postgresql_python_packages'] = []
default['openstack']['network']['platform']['nova_network_packages'] = []
default['openstack']['network']['platform']['quantum_server_packages'] = []
default['openstack']['network']['platform']['quantum_client_packages'] = []
default['openstack']['network']['platform']['quantum_packages'] = ['openstack']
default['openstack']['network']['platform']['quantum_dhcp_packages'] = []
default['openstack']['network']['platform']['quantum_l3_packages'] = []
default['openstack']['network']['platform']['quantum_metadata_agent_packages'] = []
default['openstack']['network']['platform'][''] = []

default['openstack']['network']['platform']['quantum_linuxbridge_agent_service'] = 'quantum-plugin-linuxbridge-agent'

# use syslog by default
default['openstack']['network']['syslog']['use'] = true

# event notification
default['openstack']['network']['notifiers'] = %w(log_notifier rpc_notifier)

# set sysctl properties
default['sysctl']['params']['net']['ipv4']['ip_forward'] = 1
default['sysctl']['params']['net']['bridge']['bridge-nf-call-iptables'] = 1
default['sysctl']['params']['net']['bridge']['bridge-nf-call-ip6tables'] = 1
default['sysctl']['params']['net']['bridge']['bridge-nf-call-arptables'] = 1

# process monitoring
default['openstack']['network']['server_processes'] = [
  { 'name' => 'quantum-server', 'shortname' => 'quantum-server' }
]

default['openstack']['network']['agent_processes'] = [
  { 'name' => 'quantum-ns-metadata-proxy', 'shortname' => 'quantum-ns-meta' },
  { 'name' => 'quantum-linuxbridge-agent', 'shortname' => 'quantum-linuxbr' },
  { 'name' => 'quantum-dhcp-agent', 'shortname' => 'quantum-dhcp-ag' },
  { 'name' => 'quantum-metadata-agent', 'shortname' => 'quantum-metadat' },
  { 'name' => 'quagga/zebra', 'shortname' => 'zebra' },
  { 'name' => 'quagga/ripd', 'shortname' => 'ripd' },
  { 'name' => 'dnsmasq', 'shortname' => 'dnsmasq' }
]
