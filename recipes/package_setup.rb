#
# Cookbook Name:: ktc-network
# Recipe:: package_setup
#

include_recipe "sudo"
include_recipe "ktc-package"

group node["openstack"]["network"]["platform"]["group"] do
  system true
end

user node["openstack"]["network"]["platform"]["user"] do
  home "/var/lib/quantum"
  gid node["openstack"]["network"]["platform"]["group"]
  shell "/bin/false"
  system  true
  supports :manage_home => true
end

sudo "quantum_sudoers" do
  user     node["openstack"]["network"]["platform"]["user"]
  host     "ALL"
  runas    "root"
  nopasswd true
  commands ["/usr/local/bin/quantum-rootwrap"]
end

%w|
  /var/log/quantum
  /var/run/quantum
  /var/lib/quantum/.python-eggs
|.each do |d|
  directory "#{d}" do
    owner node["openstack"]["network"]["platform"]["user"]
    group node["openstack"]["network"]["platform"]["group"]
    mode 00755
    action :create
  end
end

%w/
  quantum
  quantum-check-nvp-config
  quantum-db-manage
  quantum-debug
  quantum-dhcp-agent
  quantum-dhcp-agent-dnsmasq-lease-update
  quantum-l3-agent
  quantum-lbaas-agent
  quantum-linuxbridge-agent
  quantum-metadata-agent
  quantum-nec-agent
  quantum-netns-cleanup
  quantum-ns-metadata-proxy
  quantum-openvswitch-agent
  quantum-ovs-cleanup
  quantum-rootwrap
  quantum-ryu-agent
  quantum-server
/.each do |p|
  link "/usr/bin/#{p}" do
    to "/opt/openstack/quantum/bin/#{p}"
  end
end
