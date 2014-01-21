return  unless chef_environment == "ipc-stage"
# we want to override defaults
include_attribute "ktc-network::ng_l3"

# override this like the example below
default["openstack"]["network"]["ng_l3"]["setup_entities"] = true
default["openstack"]["network"]["ng_l3"]["networks"] = [
  {
    "zone" => "cheonan.dev.ktis",
    "options" => {
      "name" => "cheonan.dev.ktis",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "cheonan.dev.ktis",
    "options" => {
      "name" => "cheonan.dev.ktis.private",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "cheonan.dev.dmz",
    "options" => {
      "name" => "cheonan.dev.dmz",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "cheonan.dev.dmz",
    "options" => {
      "name" => "cheonan.dev.dmz.private",
      "multihost:multi_host" => true,
      "shared" => true
    }
  }
]
default["openstack"]["network"]["ng_l3"]["subnets"] = [
  {
    "zone" => "cheonan.dev.ktis",
    "search_id" => { :network => { "name" => "cheonan.dev.ktis" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.dev.ktis",
      "cidr" => "10.210.10.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.210.10.11", "end" => "10.210.10.250" }]
    }
  },
  {
    "zone" => "cheonan.dev.ktis",
    "search_id" => { :network => { "name" => "cheonan.dev.ktis.private" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.dev.ktis.private",
      "cidr" => "10.210.11.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.210.11.11", "end" => "10.210.11.250" }]
    }
  },
  {
    "zone" => "cheonan.dev.dmz",
    "search_id" => { :network => { "name" => "cheonan.dev.dmz" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.dev.dmz",
      "cidr" => "10.210.12.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.210.12.11", "end" => "10.210.12.250" }]
    }
  },
  {
    "zone" => "cheonan.dev.dmz",
    "search_id" => { :network => { "name" => "cheonan.dev.dmz.private" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.dev.dmz.private",
      "cidr" => "10.210.13.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.210.13.11", "end" => "10.210.13.250" }]
    }
  }
]
