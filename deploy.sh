curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh

export APPROVE_INSTALL=y
export APPROVE_IP=y
export ENDPOINT=$(curl -4 http://checkip.amazonaws.com)
export IPV6_SUPPORT=n
export PORT_CHOICE=1
export PROTOCOL_CHOICE=1
export DNS=1
export COMPRESSION_ENABLED=n
export CUSTOMIZE_ENC=n
export CLIENT=bugVPN
export PASS=1

sudo -E ./openvpn-install.sh
