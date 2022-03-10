#wlaczenie w kernelu forwardowania
echo 1 > /proc/sys/net/ipv4/ip_forward

# czyszczenie starych regul
iptables -F
iptables -X
iptables -t nat -X
iptables -t nat -F
iptables -t mangle -F
iptables -t mangle -X

# ustawienie domyslnej polityki
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# utrzymanie polaczen nawiazanych
iptables -A INPUT -j ACCEPT -m state --state ESTABLISHED,RELATED
iptables -A FORWARD -j ACCEPT -m state --state ESTABLISHED,RELATED
iptables -A OUTPUT -j ACCEPT -m state --state ESTABLISHED,RELATED

# udostepniaie internetu w sieci lokalnej
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A FORWARD -j ACCEPT
