# Unified BGP Configuration with Tunnel
# Created by merging three BGP configurations

# RouterOS Version: 6.48.7, 6.49.8, 6.47.10
# Router Models: RouterBOARD 941-2nD

/interface wireless
set [find default-name=wlan1] ssid=KJ
/interface wireless security-profiles
set [find default=yes] supplicant-identity=KJ

/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool1 ranges=14.14.14.2-14.14.14.254
add name=dhcp_pool2 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool3 ranges=17.17.1.2-17.17.1.254
add name=dhcp_pool4 ranges=176.10.10.2-176.10.10.254

/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=ether3 name=dhcp2
add address-pool=dhcp_pool2 disabled=no interface=ether2 name=dhcp3
add address-pool=dhcp_pool3 disabled=no interface=ether3 name=dhcp4
add address-pool=dhcp_pool4 disabled=no interface=ether3 name=dhcp5

/ip address
add address=172.16.1.1/24 interface=ether1 network=172.16.1.0
add address=10.10.10.1/24 interface=ether2 network=10.10.10.0
add address=14.14.14.1/24 interface=ether3 network=14.14.14.0
add address=172.16.1.2/24 interface=ether1 network=172.16.1.0
add address=192.168.1.1/24 interface=ether2 network=192.168.1.0
add address=17.17.1.1/24 interface=ether3 network=17.17.1.0
add address=176.10.10.1/24 interface=ether3 network=176.10.10.0

/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=14.14.14.0/24 gateway=14.14.14.1
add address=192.168.10.0/24 gateway=192.168.10.1
add address=17.17.1.0/24 gateway=17.17.1.1
add address=176.10.10.0/24 gateway=176.10.10.1

/routing bgp instance
set default as=65001 redistribute-connected=yes
set default as=65002 redistribute-connected=yes
set default as=65003 redistribute-connected=yes

/routing bgp network
add network=10.10.10.0/24
add network=14.14.14.0/24
add network=172.16.1.0/24
add network=192.168.1.0/24
add network=17.17.1.0/24
add network=176.10.10.0/24

/routing bgp peer
add name=peer1-to-router2 remote-address=172.16.1.2 remote-as=65002
add name=peer2-to-router3 remote-address=10.10.10.2 remote-as=65003
add name=peer3-to-router1 remote-address=192.168.1.1 remote-as=65001

# Tunnel Configuration (GRE Tunnel Example)
/interface gre
add name=gre1 remote-address=192.168.1.2 local-address=172.16.1.1
add name=gre2 remote-address=10.10.10.2 local-address=172.16.1.1

/ip address
add address=192.168.100.1/30 interface=gre1 network=192.168.100.0
add address=192.168.200.1/30 interface=gre2 network=192.168.200.0

/ip route
add distance=1 gateway=192.168.100.2
add distance=1 gateway=192.168.200.2

# System Identity
/system identity
set name="Unified Router"
