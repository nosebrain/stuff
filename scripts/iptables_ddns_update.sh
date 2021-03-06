#!/bin/bash
# required packages: iptables-persistent
# based on http://unix.stackexchange.com/a/91711
# adapted for multiple DDNS sources
IPTABLES=/sbin/iptables

HOSTNAME=$1
NETWORK_DEVICE=$2

NORMED_HOSTNAME=`echo $HOSTNAME | tr -cd '[[:alnum:]]'`
LOG_BASE_PATH=/var/log/ddns_update
LOGFILE=$LOG_BASE_PATH/$NORMED_HOSTNAME.log

# get the old ip address
mkdir -p $LOG_BASE_PATH
touch $LOGFILE
Old_IP=$(cat $LOGFILE)

Current_IP=$(host $HOSTNAME | head -n1 | cut -f4 -d' ')

if ! [[ $Current_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "$Current_IP is no valid ip address"
  exit 1
fi

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
