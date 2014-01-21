#
# Cookbook Name:: ktc-network
# Recipe:: common
#

include_recipe "ktc-network::package_setup"
include_recipe "openstack-network::common"

chef_gem "chef-rewind"
require 'chef/rewind'

rewind :template => "/etc/quantum/quantum.conf" do
  cookbook_name "ktc-network"
end

driver_name = node["openstack"]["network"]["interface_driver"].split('.').last.downcase
main_plugin = node["openstack"]["network"]["interface_driver_map"][driver_name]

case main_plugin
when "linuxbridge"

  rewind :template => "/etc/quantum/plugins/linuxbridge/linuxbridge_conf.ini" do
    cookbook_name "ktc-network"
  end
end
