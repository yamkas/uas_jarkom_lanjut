# Gabungan Konfigurasi R1, R2, dan R3 dengan Tunnel
# Router1
/interface wireless
set [ find default-name=wlan1 ] ssid=CITRA
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=CITRA
/ip pool
add name=dhcp_pool0 ranges=192.168.1.2-192.168.1.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
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
/interface gre
add name=gre1 local-address=12.12.12.1 remote-address=12.12.12.2
/system identity
set name=Router1

# Router2
/interface wireless
set [ find default-name=wlan1 ] ssid=CITRA
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=CITRA
/ip pool
add name=dhcp_pool0 ranges=192.168.2.2-192.168.2.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
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
/interface gre
add name=gre1 local-address=12.12.12.2 remote-address=12.12.12.1
add name=gre2 local-address=10.10.10.1 remote-address=10.10.10.2
/system identity
set name="Router 2 KJ"

# Router3
/interface wireless
set [ find default-name=wlan1 ] ssid=CITRA
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=CITRA
/ip pool
add name=dhcp_pool0 ranges=192.168.3.2-192.168.3.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
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
/interface gre
add name=gre2 local-address=10.10.10.2 remote-address=10.10.10.1
/system identity
set name="R 3"
