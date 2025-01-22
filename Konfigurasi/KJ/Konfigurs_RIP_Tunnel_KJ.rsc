# Gabungan Konfigurasi Router dengan Tunnel
# Konfigurasi Global
/interface wireless
set [ find default-name=wlan1 ] ssid=KJ
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=KJ

# Konfigurasi Router 1
/ip pool
add name=dhcp_pool_r1 ranges=192.168.1.2-192.168.1.254
/ip dhcp-server
add address-pool=dhcp_pool_r1 disabled=no interface=ether2 name=dhcp1_r1
/ip address
add address=192.168.1.1/24 interface=ether2 network=192.168.1.0
add address=12.12.12.1/24 interface=ether4 network=12.12.12.0
add address=11.11.11.1/24 interface=ether3 network=11.11.11.0
/ip dhcp-server network
add address=192.168.1.0/24 gateway=192.168.1.1
/routing rip interface
add send=v1-2
/routing rip neighbor
add address=12.12.12.2
add address=10.10.10.2
/routing rip network
add network=12.12.12.0/24
add network=11.11.11.0/24
add network=192.168.1.0/24
/system identity
set name=Router1

# Konfigurasi Router 2
/ip pool
add name=dhcp_pool_r2 ranges=192.168.2.2-192.168.2.254
/ip dhcp-server
add address-pool=dhcp_pool_r2 disabled=no interface=ether2 name=dhcp1_r2
/ip address
add address=192.168.2.1/24 interface=ether2 network=192.168.2.0
add address=10.10.10.1/24 interface=ether3 network=10.10.10.0
add address=12.12.12.2/24 interface=ether4 network=12.12.12.0
/ip dhcp-server network
add address=192.168.2.0/24 gateway=192.168.2.1
/routing rip interface
add send=v1-2
/routing rip neighbor
add address=12.12.12.1
add address=10.10.10.2
/routing rip network
add network=10.10.10.0/24
add network=12.12.12.0/24
add network=192.168.2.0/24
/system identity
set name="Router 2 KJ"

# Konfigurasi Router 3
/ip pool
add name=dhcp_pool_r3 ranges=192.168.3.2-192.168.3.254
/ip dhcp-server
add address-pool=dhcp_pool_r3 disabled=no interface=ether2 name=dhcp1_r3
/ip address
add address=11.11.11.2/24 interface=ether4 network=11.11.11.0
add address=10.10.10.2/24 interface=ether3 network=10.10.10.0
add address=192.168.3.1/24 interface=ether2 network=192.168.3.0
/ip dhcp-server network
add address=192.168.3.0/24 dns-server=0.0.0.0 gateway=192.168.3.1
/routing rip interface
add send=v1-2
/routing rip neighbor
add address=10.10.10.1
add address=11.11.11.1
/routing rip network
add network=10.10.10.0/24
add network=11.11.11.0/24
add network=192.168.3.0/24
/system identity
set name="R 3"

# Konfigurasi Tunnel
/interface ipip
add name=tunnel1 local-address=192.168.1.1 remote-address=192.168.2.1
add name=tunnel2 local-address=192.168.2.1 remote-address=192.168.3.1
/ip address
add address=192.168.100.1/30 interface=tunnel1 network=192.168.100.0
add address=192.168.100.2/30 interface=tunnel1 network=192.168.100.0
add address=192.168.101.1/30 interface=tunnel2 network=192.168.101.0
add address=192.168.101.2/30 interface=tunnel2 network=192.168.101.0
/routing rip network
add network=192.168.100.0/30
add network=192.168.101.0/30
