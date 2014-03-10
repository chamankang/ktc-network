return  unless chef_environment == 'mkd_stag'
# we want to override defaults
include_attribute 'ktc-network::ng_l3'

# override this like the example below
default['openstack']['network']['ng_l3']['setup_entities'] = true
default['openstack']['network']['ng_l3']['networks'] = [
  {
    'zone' => 'mokdong.dev.ktis',
    'options' => {
      'name' => 'mokdong.dev.ktis',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.dev.ktis',
    'options' => {
      'name' => 'mokdong.dev.ktis.private',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.dev.dmz',
    'options' => {
      'name' => 'mokdong.dev.dmz',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.dev.dmz',
    'options' => {
      'name' => 'mokdong.dev.dmz.private',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.prod.ktis',
    'options' => {
      'name' => 'mokdong.prod.ktis',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.prod.ktis',
    'options' => {
      'name' => 'mokdong.prod.ktis.private',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.prod.dmz',
    'options' => {
      'name' => 'mokdong.prod.dmz',
      'multihost:multi_host' => true,
      'shared' => true
    }
  },
  {
    'zone' => 'mokdong.prod.dmz',
    'options' => {
      'name' => 'mokdong.prod.dmz.private',
      'multihost:multi_host' => true,
      'shared' => true
    }
  }
]
default['openstack']['network']['ng_l3']['subnets'] = [
  {
    'zone' => 'mokdong.dev.ktis',
    'search_id' => { network: { 'name' => 'mokdong.dev.ktis' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.dev.ktis',
      'cidr' => '10.180.10.0/24',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '10.180.10.11', 'end' => '10.180.10.250' }]
    }
  },
  {
    'zone' => 'mokdong.dev.ktis',
    'search_id' => { network: { 'name' => 'mokdong.dev.ktis.private' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.dev.ktis.private',
      'cidr' => '10.180.11.0/24',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '10.180.11.11', 'end' => '10.180.11.250' }]
    }
  },
  {
    'zone' => 'mokdong.dev.dmz',
    'search_id' => { network: { 'name' => 'mokdong.dev.dmz' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.dev.dmz',
      'cidr' => '14.63.205.32/27',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '14.63.205.34', 'end' => '14.63.205.62' }]
    }
  },
  {
    'zone' => 'mokdong.dev.dmz',
    'search_id' => { network: { 'name' => 'mokdong.dev.dmz.private' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.dev.dmz.private',
      'cidr' => '10.180.13.0/24',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '10.180.13.11', 'end' => '10.180.13.250' }]
    }
  },
  {
    'zone' => 'mokdong.prod.ktis',
    'search_id' => { network: { 'name' => 'mokdong.prod.ktis' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.prod.ktis',
      'cidr' => '10.180.14.0/24',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '10.180.14.11', 'end' => '10.180.14.250' }]
    }
  },
  {
    'zone' => 'mokdong.prod.ktis',
    'search_id' => { network: { 'name' => 'mokdong.prod.ktis.private' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.prod.ktis.private',
      'cidr' => '10.180.15.0/24',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '10.180.15.11', 'end' => '10.180.15.250' }]
    }
  },
  {
    'zone' => 'mokdong.prod.dmz',
    'search_id' => { network: { 'name' => 'mokdong.prod.dmz' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.prod.dmz',
      'cidr' => '14.63.205.224/28',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '14.63.205.226', 'end' => '14.63.205.238' }]
    }
  },
  {
    'zone' => 'mokdong.prod.dmz',
    'search_id' => { network: { 'name' => 'mokdong.prod.dmz.private' } },
    'options' => {
      'network_id' => :network,
      'name' => 'mokdong.prod.dmz.private',
      'cidr' => '14.63.205.240/28',
      'dns_nameservers' => ['8.8.8.8'],
      'gateway_ip' => :null,
      'allocation_pools' => [{ 'start' => '14.63.205.242', 'end' => '14.63.205.254' }]
    }
  }
]
