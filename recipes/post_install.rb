#
# Load bridge module
# 'modules' recipe reads module list from node["modules"] and loads them
#
include_recipe 'modules'

chef_gem 'chef-rewind'
require 'chef/rewind'

# Ubuntu Precise and Quantal provide 'module-init-tools' instead of 'kmod'.
case node['platform']
when 'ubuntu'
  if Gem::Dependency.new(nil, '<= 12.10').match?(nil, node['platform_version'])
    rewind package: 'kmod' do
      package_name 'module-init-tools'
    end
  end
end

zone_subnets = node['openstack']['network']['ng_l3']['subnets'].select do |s|
  s['zone'] == node['openstack']['availability_zone']
end
zone_cidrs = zone_subnets.map { |s| s['options']['cidr'] }
management_cidr = nil
iface = KTC::Network.if_lookup 'management'
ip = KTC::Network.address 'management'
node['network']['interfaces'][iface]['routes'].each do |route|
  if route.key?('src') && (route['src'] == ip)
    management_cidr = route['destination']
    break
  end
end

# rubocop:disable LineLength
rip_iface = KTC::Network.if_lookup node['openstack']['network']['quagga']['rip_network']

#
# Drop packets from VMs to management network
#
include_recipe 'simple_iptables'

zone_cidrs.each do |source_cidr|
  simple_iptables_rule 'ng-INPUT' do
    direction 'INPUT'
    rule "-s #{source_cidr} -d #{management_cidr}"
    jump 'DROP'
  end

  simple_iptables_rule 'ng-FORWARD' do
    direction 'FORWARD'
    rule "-s #{source_cidr} -d #{management_cidr}"
    jump 'DROP'
  end
end

#
# Quagga Settings
#
package 'quagga'

service 'quagga' do
  supports restart: true
  action [:enable, :start]
end

template '/etc/quagga/daemons' do
  source 'quagga/daemons.erb'
  owner 'root'
  group 'root'
  mode '00644'
  action :create
  notifies :restart, 'service[quagga]', :delayed
end

template '/etc/quagga/zebra.conf' do
  source 'quagga/zebra.conf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  action :create
  notifies :restart, 'service[quagga]', :delayed
end

template '/etc/quagga/ripd.conf' do
  source 'quagga/ripd.conf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  action :create
  variables(
    cidrs: zone_cidrs,
    network: rip_iface
  )
  notifies :restart, 'service[quagga]', :delayed
end
