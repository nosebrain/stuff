#!/bin/bash

USER_NAME=$1
USER_ID=$2
REAL_NAME=$3

sudo dscl . -create /Users/_${USER_NAME}
sudo dscl . -create /Users/_${USER_NAME} uid ${USER_ID}
sudo dscl . -create /Users/_${USER_NAME} gid ${USER_ID}
sudo dscl . -create /Users/_${USER_NAME} NFSHomeDirectory /var/empty
sudo dscl . -create /Users/_${USER_NAME} UserShell /usr/bin/false
sudo dscl . -create /Users/_${USER_NAME} RealName "${REAL_NAME}"
sudo dscl . -create /Users/_${USER_NAME} passwd "*"