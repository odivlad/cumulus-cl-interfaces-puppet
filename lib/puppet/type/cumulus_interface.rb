require 'puppet/parameter/boolean'
Puppet::Type.newtype(:cumulus_interface) do
  desc 'Config front panel ports, SVI, loopback,
  mgmt ports on Cumulus Linux. To configure a bond use the
  cumulus_bond module. To configure a bridge interface use
  the cumulus_bridge module.
  '
  ensurable do
    newvalue(:outofsync) do
    end
    newvalue(:insync) do
      provider.update_config
    end
    defaultto do
      :insync
    end
  end

  newparam(:name) do
    desc 'interface name'
  end

  newparam(:ipv4) do
    desc 'list of ipv4 addresses
    ip address must be in CIDR format and subnet mask included
    Example: 10.1.1.1/30'
  end

  newparam(:ipv6) do
    desc 'list of ipv6 addresses
    ip address must be in CIDR format and subnet mask included
    Example: 10:1:1::1/127'
  end

  newparam(:alias_name) do
    desc 'interface description'
  end

  newparam(:addr_method) do
    desc 'address assignment method'
    newvalues(:dhcp, :loopback)
  end

  newparam(:speed) do
    desc 'link speed in MB. Example "1000" means 1G'
  end

  newparam(:mtu) do
    desc 'link mtu. Can be 1500 to 9000 KBs'
  end

  newparam(:virtual_ip) do
    desc 'virtual IP component of Cumulus Linux VRR config'
  end

  newparam(:virtual_mac) do
    desc 'virtual MAC component of Cumulus Linux VRR config'
  end

  newparam(:vids) do
    desc 'list of vlans. Only configured on vlan aware ports'
  end

  newparam(:pvid) do
    desc 'vlan transmitted untagged across the link (native vlan)'
  end

  newparam(:location) do
    desc 'location of interface files'
    defaultto '/etc/network/interfaces.d'
  end

  newparam(:mstpctl_portnetwork) do
    desc 'configures bridge assurance. Ensure that port is in vlan
    aware mode'
  end

  newparam(:mstpctl_bpduguard) do
    desc 'configures bpdu guard. Ensure that the port is in vlan
    aware mode'
  end

  newparam(:clagd_enable, :boolean => true,
          :parent => Puppet::Parameter::Boolean) do
    desc 'enable CLAG on the interface. Interface must be in vlan \
    aware mode'
  end

  newparam(:clagd_priority) do
    desc 'determines which switch is the primary role. The lower priority
    switch will assume the primary role. Range can be between 0-65535'
  end

  newparam(:clagd_peer_ip) do
    desc 'clagd peerlink adjacent port IP'
  end

  newparam(:clagd_sys_mac) do
    desc 'clagd system mac. Must the same across both Clag switches.
    range must be with 44:38:38:ff'
  end

  newparam(:clagd_args) do
    desc 'additional Clag parameters'
  end

  # require that the directory specified by location exists
  autorequire(:file) do
    [@parameters[:location].value]
  end
end
