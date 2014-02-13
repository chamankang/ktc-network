return  unless chef_environment == "mkd2"
# we want to override defaults
include_attribute "ktc-network::ng_l3"

# override this like the example below
default["openstack"]["network"]["ng_l3"]["setup_entities"] = true
default["openstack"]["network"]["ng_l3"]["networks"] = [
  {
    "zone" => "mokdong.dev.ktis",
    "options" => {
      "name" => "mokdong.dev.ktis",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "mokdong.dev.ktis",
    "options" => {
      "name" => "mokdong.dev.ktis.private",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "mokdong.dev.dmz",
    "options" => {
      "name" => "mokdong.dev.dmz",
      "multihost:multi_host" => true,
      "shared" => true
    }
  },
  {
    "zone" => "mokdong.dev.dmz",
    "options" => {
      "name" => "mokdong.dev.dmz.private",
      "multihost:multi_host" => true,
      "shared" => true
    }
  }
]
default["openstack"]["network"]["ng_l3"]["subnets"] = [
  {
    "zone" => "mokdong.dev.ktis",
    "search_id" => { :network => { "name" => "mokdong.dev.ktis" } },
    "options" => {
      "network_id" => :network,
      "name" => "mokdong.dev.ktis",
      "cidr" => "10.100.10.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.100.10.11", "end" => "10.100.10.250" }]
    }
  },
  {
    "zone" => "mokdong.dev.ktis",
    "search_id" => { :network => { "name" => "mokdong.dev.ktis.private" } },
    "options" => {
      "network_id" => :network,
      "name" => "mokdong.dev.ktis.private",
      "cidr" => "10.100.11.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.100.11.11", "end" => "10.100.11.250" }]
    }
  },
  {
    "zone" => "mokdong.dev.dmz",
    "search_id" => { :network => { "name" => "mokdong.dev.dmz" } },
    "options" => {
      "network_id" => :network,
      "name" => "mokdong.dev.dmz",
      "cidr" => "10.100.12.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.100.12.11", "end" => "10.100.12.250" }]
    }
  },
  {
    "zone" => "mokdong.dev.dmz",
    "search_id" => { :network => { "name" => "mokdong.dev.dmz.private" } },
    "options" => {
      "network_id" => :network,
      "name" => "mokdong.dev.dmz.private",
      "cidr" => "10.100.13.0/24",
      "dns_nameservers" => ["8.8.8.8"],
      "gateway_ip" => :null,
      "allocation_pools" => [{ "start" => "10.100.13.11", "end" => "10.100.13.250" }]
    }
  }
]
