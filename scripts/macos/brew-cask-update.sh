#!/bin/bash

APPS="$@"

echo $APPS

for APP in `echo $APPS`; do
  echo "updating $APP; please wait"
  RESULT=$( brew cask install --force "$APP" | tee /dev/tty)
  APP_PATH=`echo "$RESULT" | grep "Moving App" | cut -d "'" -f 4`
  xattr -r -d com.apple.quarantine "$APP_PATH"  
done