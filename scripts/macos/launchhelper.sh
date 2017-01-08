#!/bin/bash

APP=$1
ACTION=$2
APP_KEY=""

case $APP in
  mysql)
    APP_NAME="MySQL"
    APP_KEY="/Library/LaunchDaemons/homebrew.mxcl.mysql.plist"
    CASK="mysql"
    ;;
  *)
    echo "app not configured"
    exit -1
esac

case $ACTION in
  start)
    ACTION_TEXT="starting"
    ACTION="load"
    ;;
  stop)
    ACTION_TEXT="stopping"
    ACTION="unload"
    ;;
  brewupdate)
    echo "updating $APP"
    echo "stopping $APP"
    $0 $1 stop
    brew upgrade ${CASK}
    $0 $1 start
    exit 0
    ;;
  *)
    echo "invalid action"
    exit -1
esac

echo "${ACTION_TEXT} ${APP_NAME}"

sudo launchctl ${ACTION} ${APP_KEY}

echo "Done."