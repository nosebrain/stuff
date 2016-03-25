#!/bin/bash
# based on http://unix.stackexchange.com/a/91711
# added hostname parameter and network device parameter

HOSTNAME=$1
NORMED_HOSTNAME=`echo $HOSTNAME | tr -cd '[[:alnum:]]'`
LOG_BASE_PATH=/var/log/ddns_update
LOGFILE=$LOG_BASE_PATH/$NORMED_HOSTNAME.log
NETWORK_DEVICE=$2

# get the old ip address
mkdir -p $LOG_BASE_PATH
touch $LOGFILE
Old_IP=$(cat $LOGFILE)

Current_IP=$(host $HOSTNAME | head -n1 | cut -f4 -d' ')
DATE=`date`

if [ "$Current_IP" = "$Old_IP" ] ; then
  echo "$DATE ${HOSTNAME}: IP address has not changed"
else
  iptables -D INPUT -i $NETWORK_DEVICE -s $Old_IP -j ACCEPT
  iptables -I INPUT -i $NETWORK_DEVICE -s $Current_IP -j ACCEPT
  echo $Current_IP > $LOGFILE
  echo "$DATE ${HOSTNAME}: iptables have been updated"
fi