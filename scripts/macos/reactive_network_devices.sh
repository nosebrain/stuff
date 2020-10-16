#!/bin/bash

networksetup -listallnetworkservices | grep '^*' | while read -r line ; do
  NETWORK_DEVICE=${line:1}
  echo "reactivating $NETWORK_DEVICE"
  networksetup -setnetworkserviceenabled "$NETWORK_DEVICE" on
done
