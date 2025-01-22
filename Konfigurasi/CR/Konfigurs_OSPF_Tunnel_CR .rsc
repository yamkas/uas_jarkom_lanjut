# jan/02/1970 00:22:27 by RouterOS 6.49.8
# software id = RWA7-BHWK
#
# model = RB941-2nD
# serial number = HF609BYEWH7
/interface bridge
add comment="OSPF loopback" name=loopback
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface ipip
add local-address=10.1.1.1 name=ipip-tunnel-to-B remote-address=172.16.1.1
add local-address=10.1.1.1 name=ipip-tunnel-to-C remote-address=192.168.100.1
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
add address=10.255.1.1/30 interface=ipip-tunnel-to-B network=10.255.1.0
add address=10.255.2.1/30 interface=ipip-tunnel-to-C network=10.255.2.0
/ip dhcp-server network
add address=192.168.1.16/28 gateway=192.168.1.17
/ip firewall filter
add action=accept chain=input comment="Allow IPIP Tunnel" protocol=ipencap
/ip route
add distance=1 dst-address=10.10.10.0/24 gateway=10.255.1.2
add distance=1 dst-address=10.20.20.0/24 gateway=10.255.2.2
/routing ospf network
add area=backbone comment=Loopback network=172.16.16.2/32
add area=backbone comment=koneksi_ke_router1 network=192.168.0.0/30
add area=backbone comment=koneksi_ke_router3 network=192.168.0.4/30
add area=backbone comment=LAN network=192.168.1.16/28
