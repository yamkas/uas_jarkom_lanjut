# jan/02/1970 00:00:00 by RouterOS 6.x
# software id = CombinedConfig
#
# Unified Configuration with Tunnel Setup
/interface wireless
set [ find default-name=wlan1 ] ssid=KHI
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=KHI
/ip pool
add name=dhcp_pool1 ranges=192.168.1.2-192.168.1.254
add name=dhcp_pool2 ranges=192.168.2.2-192.168.2.254
add name=dhcp_pool3 ranges=192.168.3.2-192.168.3.254
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=ether2 name=dhcp1_router1
add address-pool=dhcp_pool2 disabled=no interface=ether2 name=dhcp1_router2
add address-pool=dhcp_pool3 disabled=no interface=ether2 name=dhcp1_router3
/ip address
add address=192.168.1.1/24 interface=ether2 network=192.168.1.0
add address=12.12.12.1/24 interface=ether4 network=12.12.12.0
add address=11.11.11.1/24 interface=ether3 network=11.11.11.0
add address=192.168.2.1/24 interface=ether2 network=192.168.2.0
add address=10.10.10.1/24 interface=ether3 network=10.10.10.0
add address=12.12.12.2/24 interface=ether4 network=12.12.12.0
add address=192.168.3.1/24 interface=ether2 network=192.168.3.0
add address=10.10.10.2/24 interface=ether3 network=10.10.10.0
add address=11.11.11.2/24 interface=ether4 network=11.11.11.0
/ip dhcp-server network
add address=192.168.1.0/24 gateway=192.168.1.1
add address=192.168.2.0/24 gateway=192.168.2.1
add address=192.168.3.0/24 gateway=192.168.3.1
/routing rip interface
add send=v1-2
/routing rip neighbor
add address=12.12.12.2
add address=10.10.10.2
add address=10.10.10.1
add address=11.11.11.1
/routing rip network
add network=12.12.12.0/24
add network=11.11.11.0/24
add network=10.10.10.0/24
add network=192.168.1.0/24
add network=192.168.2.0/24
add network=192.168.3.0/24
/interface ipip
add name=tunnel1 local-address=12.12.12.1 remote-address=12.12.12.2
add name=tunnel2 local-address=11.11.11.1 remote-address=11.11.11.2
/ip address
add address=172.16.1.1/30 interface=tunnel1 network=172.16.1.0
add address=172.16.2.1/30 interface=tunnel2 network=172.16.2.0
/routing rip network
add network=172.16.1.0/30
add network=172.16.2.0/30
/system identity
set name="Combined Router Configuration"
