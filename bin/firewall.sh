#!/bin/sh
# chkconfig: 3 21 91
# description: Firewall

IPT=/sbin/iptables

case "$1" in
start)
$IPT -F INPUT
$IPT -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
# SSH 
$IPT -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
# SMTP
$IPT -A INPUT -i eth0 -p tcp --dport 25 -j ACCEPT
#
$IPT -A INPUT -i eth0 -p tcp --dport 53 -j ACCEPT
$IPT -A INPUT -i eth0 -p udp --dport 53 -j ACCEPT
#HTTP
$IPT -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
# POP3
$IPT -A INPUT -i eth0 -p tcp --dport 110 -j ACCEPT
# HTTPS
$IPT -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT
# WEBMIN
$IPT -A INPUT -i eth0 -p tcp --dport 10000 -j ACCEPT
#Redmine
$IPT -A INPUT -i eth0 -p tcp --dport 3000 -j ACCEPT

# ACCEPT OVH MONITORING
$IPT -A INPUT -i eth0 -p icmp --source proxy.ovh.net -j ACCEPT
$IPT -A INPUT -i eth0 -p icmp --source proxy.p19.ovh.net -j ACCEPT
$IPT -A INPUT -i eth0 -p icmp --source proxy.rbx.ovh.net -j ACCEPT
$IPT -A INPUT -i eth0 -p icmp --source proxy.rbx2.ovh.net -j ACCEPT
$IPT -A INPUT -i eth0 -p icmp --source ping.ovh.net -j ACCEPT
$IPT -A INPUT -i eth0 -p icmp --source 91.121.72.250 -j ACCEPT # IP = aaa.bbb.ccc obtenue selon la règle precedente
$IPT -A INPUT -i eth0 -p icmp --source 91.121.72.249 -j ACCEPT # temporaire, seulement pour serveurs HG
$IPT -A INPUT -i eth0 -p icmp --source 91.121.72.251 -j ACCEPT # IP pour system de monitoring  

# FILER RAID
$IPT -A INPUT -i eth0 -p tcp --source 192.168.0.0/16 -j ACCEPT
$IPT -A INPUT -i eth0 -p udp --source 192.168.0.0/16 -j ACCEPT

$IPT -A INPUT -i eth0 -j REJECT

$IPT -A INPUT -s 189.224.172.119 -j DROP
  

exit 0
;;

stop)
  $IPT -F INPUT
  exit 0
;;
*)
  echo "Usage: /etc/init.d/firewall {start|stop}"
  exit 1
;;
esac




