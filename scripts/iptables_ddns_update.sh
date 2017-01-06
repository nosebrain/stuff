#!/bin/bash
# required packages: iptables-persistent
# 
# based on http://unix.stackexchange.com/questions/91701/ufw-allow-traffic-only-from-a-domain-with-dynamic-ip-address
# adapted for multiple DDNS sources
IPTABLES=/sbin/iptables
LOG_BASE_PATH=/var/log/ddns_update

HOSTNAME=$1
NETWORK_DEVICE=$2
NORMED_HOSTNAME=`echo $HOSTNAME | tr -cd '[[:alnum:]]'`
LOGFILE=$LOG_BASE_PATH/$NORMED_HOSTNAME.log

# get the old ip address
mkdir -p $LOG_BASE_PATH
touch $LOGFILE
Old_IP=$(cat $LOGFILE)

Current_IP=$(host $HOSTNAME | cut -f4 -d' ')
DATE=`date`

if [ "$Current_IP" = "$Old_IP" ] ; then
  echo "$DATE ${HOSTNAME}: IP address has not changed ($Old_IP)"
else
  # only remove the old ip when set
  if [[ ! -z "${Old_IP// }" ]]; then
    $IPTABLES -D INPUT -i $NETWORK_DEVICE -s $Old_IP -j ACCEPT
  fi
  $IPTABLES -I INPUT -i $NETWORK_DEVICE -s $Current_IP -j ACCEPT
  echo $Current_IP > $LOGFILE
  echo "$DATE ${HOSTNAME}: iptables have been updated $Old_IP -> $Current_IP"
fi