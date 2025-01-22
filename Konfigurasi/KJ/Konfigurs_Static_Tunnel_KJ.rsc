# jan/02/1970 00:14:42 by RouterOS 6.48.6
# software id = XF27-WJ41
#
# model = RB941-2nD
# serial number = A1C30BB18CA4
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool1 ranges=192.168.20.2-192.168.20.254
add name=dhcp_pool2 ranges=192.168.30.2-192.168.30.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether3 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=ether2 name=dhcp2
add address-pool=dhcp_pool2 disabled=no interface=ether2 name=dhcp3
/ip address
add address=192.168.100.2/24 interface=ether1 network=192.168.100.0
add address=192.168.200.1/24 interface=ether2 network=192.168.200.0
add address=192.168.10.1/24 interface=ether3 network=192.168.10.0
add address=192.168.100.1/24 interface=ether1 network=192.168.100.0
add address=192.168.20.1/24 interface=ether2 network=192.168.20.0
add address=192.168.30.1/24 interface=ether2 network=192.168.30.0
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
add address=192.168.20.0/24 gateway=192.168.20.1
add address=192.168.30.0/24 gateway=192.168.30.1
/ip route
add distance=1 dst-address=192.168.20.0/24 gateway=192.168.100.1
add distance=1 dst-address=192.168.30.0/24 gateway=192.168.200.2
add distance=1 dst-address=192.168.10.0/24 gateway=192.168.100.2
add distance=1 dst-address=192.168.30.0/24 gateway=192.168.100.2
add distance=1 dst-address=192.168.10.0/24 gateway=192.168.200.1
add distance=1 dst-address=192.168.20.0/24 gateway=192.168.200.1

# Tunnel Configuration (WireGuard)
/interface wireguard
add listen-port=13231 name=wg0
/ip address
add address=10.10.10.1/24 interface=wg0 network=10.10.10.0
/ip route
add distance=1 dst-address=192.168.10.0/24 gateway=10.10.10.2
add distance=1 dst-address=192.168.20.0/24 gateway=10.10.10.2
add distance=1 dst-address=192.168.30.0/24 gateway=10.10.10.2

# Peer Configuration for Tunnel
/interface wireguard peers
add allowed-address=192.168.10.0/24,192.168.20.0/24,192.168.30.0/24 endpoint-address=192.168.100.2 endpoint-port=13231 interface=wg0 public-key="PEER_PUBLIC_KEY"
