#
# Cookbook Name:: ktc-network
# Recipe:: source_install 
#

include_recipe "sudo"
include_recipe "git"
include_recipe "python"

user node["openstack"]["network"]["platform"]["user"] do
  home "/var/lib/quantum"
  shell "/bin/false"
  supports :manage_home => true
end

sudo "quantum_sudoers" do
  user     "quantum"
  host     "ALL"
  runas    "root"
  nopasswd true
  commands ["/usr/local/bin/quantum-rootwrap"]
end

git "#{Chef::Config[:file_cache_path]}/quantum" do
  repository "https://github.com/kt-cloudware/quantum.git"
  reference "develop"
  action :sync
  notifies :install, "python_pip[pip-requires]", :immediately
  notifies :run, "bash[install_quantum]", :immediately
end

python_pip "pip-requires" do
  package_name "#{Chef::Config[:file_cache_path]}/quantum/tools/pip-requires"
  options "-r"
  action :nothing
end

bash "install_quantum" do
  cwd "#{Chef::Config[:file_cache_path]}/quantum"
  code <<-EOF
    python ./setup.py install
  EOF
  action :nothing
end

directory "/var/log/quantum" do
  owner node["openstack"]["network"]["platform"]["user"]
  group "adm"
  mode 00750
  action :create
end