# jan/02/1970 00:05:38 by RouterOS 6.47.10
# software id = R3AC-AAWW
#
# model = RB941-2nD
# serial number = D1130FD936AB
/interface wireless
set [ find default-name=wlan1 ] name=wlan2 ssid=MikroTik
/interface bridge
add comment="OSPF loopback" name=loopback
/interface ethernet
set [ find default-name=ether1 ] mac-address=78:9A:18:7F:46:56
set [ find default-name=ether2 ] mac-address=78:9A:18:7F:46:57
set [ find default-name=ether3 ] mac-address=78:9A:18:7F:46:58
set [ find default-name=ether4 ] mac-address=78:9A:18:7F:46:59
/interface pwr-line
set [ find default-name=pwr-line1 ] mac-address=78:9A:18:7F:46:5A
/interface ipip
add local-address=192.168.100.1 name=ipip-tunnel-to-A remote-address=10.1.1.1
add local-address=192.168.100.1 name=ipip-tunnel-to-B remote-address=\
    172.16.1.1
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.1.18-192.168.1.30
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether3 name=dhcp1
/routing ospf instance
set [ find default=yes ] router-id=172.16.16.2
/ip address
add address=192.168.0.2/30 comment=koneksi_ke_router1 interface=ether1 \
    network=192.168.0.0
add address=192.168.0.5/30 comment=koneksi_ke_router3 interface=ether2 \
    network=192.168.0.4
add address=192.168.1.17/28 comment=koneksi_ke_LAN interface=ether3 network=\
    192.168.1.16
add address=172.16.16.2 interface=loopback network=172.16.16.2
add address=10.255.2.2/30 interface=ipip-tunnel-to-A network=10.255.2.0
add address=10.255.3.2/30 interface=ipip-tunnel-to-B network=10.255.3.0
/ip dhcp-server network
add address=192.168.1.16/28 gateway=192.168.1.17
/ip firewall filter
add action=accept chain=input comment="Allow IPIP Tunnel" protocol=ipencap
/ip route
add distance=1 dst-address=10.0.0.0/24 gateway=10.255.2.1
add distance=1 dst-address=10.10.10.0/24 gateway=10.255.3.1
/routing ospf network
add area=backbone comment=Loopback network=172.16.16.2/32
add area=backbone comment=koneksi_ke_router1 network=192.168.0.0/30
add area=backbone comment=koneksi_ke_router3 network=192.168.0.4/30
add area=backbone comment=LAN network=192.168.1.16/28
/system identity
set name=Tunnel-KJ
