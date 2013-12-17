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

# Install pip-requires using ubuntu packages first, then install the rest with pip.
# Prefer installing ubuntu pakcages to compiling python modules on nodes.
node["openstack"]["network"]["platform"]["pip_requires_packages"].each do |pkg|
  package pkg
end

src = "https://raw.github.com/openstack/neutron/stable/havana/requirements.txt"
loc = "#{Chef::Config[:file_cache_path]}/requirements.txt"

remote_file loc do
  source src
  not_if { ::File.exist?(loc) }
end

python_pip "quantum-pip-requires" do
  package_name loc
  options "-r"
  action :nothing
end

package "quantum" do
  action :install
  version node["quantum_version"] unless node["quantum_version"].nil?
end
