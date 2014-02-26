#
## Cookbook Name:: ktc-network
## Recipe:: compute
##

include_recipe 'ktc-network::agents'
include_recipe 'ktc-network::post_install' if node['openstack']['network']['ng_l3']['setup_entities']

# Since quagga is started in post_install recipe, I think it's better to put
# the monitoring stuff here instead of 'agents' recipe.
processes = node['openstack']['network']['agent_processes']

processes.each do |process|
  check_name = process['name'].gsub(/\//, '_')
  sensu_check "check_process_#{check_name}" do
    if check_name == 'quantum-dhcp-agent'
      command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -u quantum -p #{process['name']}"
    else
      command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process['name']}"
    end
    handlers ['default']
    standalone true
    interval 30
  end
end

ktc_collectd_processes 'quantum-agent-processes' do
  input processes
end
