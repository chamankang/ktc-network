#
# Cookbook Name:: ktc-network
# Recipe:: package_install
#

include_recipe "sudo"
include_recipe "python"
include_recipe "ktc-package"

user node["openstack"]["network"]["platform"]["user"] do
  home "/var/lib/quantum"
  shell "/bin/false"
  system  true
  supports :manage_home => true
end

sudo "quantum_sudoers" do
  user     "quantum"
  host     "ALL"
  runas    "root"
  nopasswd true
  commands ["/usr/local/bin/quantum-rootwrap"]
end

directory "/var/log/quantum" do
  owner node["openstack"]["network"]["platform"]["user"]
  group "adm"
  mode 00750
  action :create
end

node["openstack"]["network"]["platform"]["requires_packages"].each do |pkg|
  package pkg
end

package "quantum" do
  action :install
  version node["quantum_version"] unless node["quantum_version"].nil?
end
