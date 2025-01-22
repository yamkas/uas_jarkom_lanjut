# Unified Configuration with GRE Tunnel
# Software ID: Combined Config
# Model: RouterBOARD
# Combined BGP Configuration with GRE Tunnels

# Interfaces
/interface wireless
set [ find default-name=wlan1 ] ssid=CITRA
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=CITRA

# IP Pools
/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool1 ranges=14.14.14.2-14.14.14.254
add name=dhcp_pool2 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool3 ranges=17.17.1.2-17.17.1.254
add name=dhcp_pool4 ranges=176.10.10.2-176.10.10.254

# DHCP Servers
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1-router1
add address-pool=dhcp_pool1 disabled=no interface=ether3 name=dhcp2-router1
add address-pool=dhcp_pool2 disabled=no interface=ether2 name=dhcp1-router2
add address-pool=dhcp_pool3 disabled=no interface=ether3 name=dhcp1-router3
add address-pool=dhcp_pool4 disabled=no interface=ether3 name=dhcp2-router3

# BGP Instance
/routing bgp instance
set default as=65001 redistribute-connected=yes
add name=bgp-router2 as=65002 redistribute-connected=yes
add name=bgp-router3 as=65003 redistribute-connected=yes

# IP Address Configuration
/ip address
add address=172.16.1.1/24 interface=ether1 network=172.16.1.0
add address=10.10.10.1/24 interface=ether2 network=10.10.10.0
add address=14.14.14.1/24 interface=ether3 network=14.14.14.0
add address=192.168.1.1/24 interface=ether2 network=192.168.1.0
add address=176.10.10.1/24 interface=ether3 network=176.10.10.0

# DHCP Server Networks
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=14.14.14.0/24 gateway=14.14.14.1
add address=17.17.1.0/24 gateway=17.17.1.1
add address=192.168.1.0/24 gateway=192.168.1.1
add address=176.10.10.0/24 gateway=176.10.10.1

# BGP Networks
/routing bgp network
add network=10.10.10.0/24
add network=14.14.14.0/24
add network=17.17.1.0/24
add network=192.168.1.0/24
add network=176.10.10.0/24

# BGP Peers
/routing bgp peer
add name=peer1-router2 remote-address=172.16.1.2 remote-as=65002
add name=peer2-router3 remote-address=10.10.10.2 remote-as=65003
add name=peer3-router3 remote-address=192.168.1.2 remote-as=65003
add name=peer4-router2 remote-address=192.168.1.1 remote-as=65002

# GRE Tunnels
/interface gre
add name=gre-router1-to-router2 local-address=172.16.1.1 remote-address=172.16.1.2
add name=gre-router1-to-router3 local-address=10.10.10.1 remote-address=10.10.10.2
add name=gre-router2-to-router3 local-address=192.168.1.1 remote-address=192.168.1.2

/ip address
add address=192.168.100.1/30 interface=gre-router1-to-router2 network=192.168.100.0
add address=192.168.100.2/30 interface=gre-router1-to-router3 network=192.168.100.4
add address=192.168.100.6/30 interface=gre-router2-to-router3 network=192.168.100.8

# System Identity
/system identity
set name="Unified-BGP-Router"
