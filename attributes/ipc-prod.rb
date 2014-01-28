return  unless chef_environment == "ipc-prod"
# we want to override defaults
include_attribute "ktc-network::ng_l3"

# override this like the example below
default["openstack"]["network"]["ng_l3"]["setup_entities"] = true
default["openstack"]["network"]["ng_l3"]["networks"] = [
  {
    "zone" => "cheonan.prod.ktis",
    "options" => {
      "name" => "cheonan.prod.ktis",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "cheonan.prod.ktis",
    "options" => {
      "name" => "cheonan.prod.ktis.private",
      "multihost:multi_host" => true,
      "shared" => true
    }
  }
]
default["openstack"]["network"]["ng_l3"]["subnets"] = [
  {
    "zone" => "cheonan.prod.ktis",
    "search_id" => { :network => { "name" => "cheonan.prod.ktis" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.prod.ktis",
      "cidr" => "10.220.76.0/24",
      "dns_nameservers" => ["147.6.44.44"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.220.76.11", "end" => "10.220.76.250" }]
    }
  },
  {
    "zone" => "cheonan.prod.ktis",
    "search_id" => { :network => { "name" => "cheonan.prod.ktis.private" } },
    "options" => {
      "network_id" => :network,
      "name" => "cheonan.prod.ktis.private",
      "cidr" => "10.220.78.0/24",
      "dns_nameservers" => ["147.6.44.44"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.220.78.11", "end" => "10.220.78.250" }]
    }
  }
]
