#!/bin/bash
#
# iptables example configuration script
#
#echo '/etc/init.d/iptables status:'
# /etc/init.d/iptables status
#echo 'wait 5s...'
# sleep 5s
#
# If connecting remotely we must first temporarily set the default policy on the INPUT chain to ACCEPT otherwise once we flush the current rules we will be locked out of our server.
#
 iptables -P INPUT ACCEPT
#
# Flush all current rules from iptables
#
# iptables -F
#
# Allow SSH connections on tcp port 22
# This is essential when working on remote servers via SSH to prevent locking yourself out of the system
#
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
# iptables -P INPUT DROP
# iptables -P FORWARD DROP
# iptables -P OUTPUT ACCEPT
#
# Set access for localhost
#
# iptables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
echo
echo 'Allow Mail(SMTP) connections on tcp port 25'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
echo 'Allow WWW(HTTP) connections on tcp port 80'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
echo 'Allow Secure WWW(HTTPS) connections on tcp port 443'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
echo 'Allow Soht Server connections on tcp port 8085'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8085 -j ACCEPT
echo
#
# Save settings
#
 /sbin/service iptables save
#
# List rules
#
echo
echo 'List rules:'
 iptables -L -v
echo 'restart iptables in 10s...'
 sleep 10s
 /sbin/service iptables restart
