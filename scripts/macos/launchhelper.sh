#!/bin/bash

APP=$1
ACTION=$2
APP_KEY=""

case $APP in
  mysql)
    APP_NAME="MySQL"
    APP_KEY="/Library/LaunchAgents/homebrew.mxcl.mysql@5.7.plist"
    CASK="mysql@5.7"
    ;;
  elasticsearch)
    APP_NAME="Elasticsearch"
    APP_KEY="/Library/LaunchAgents/homebrew.mxcl.elasticsearch@6.plist"
    CASK="elasticsearch@6"
    ;;
  haproxy)
    APP_NAME="HAProxy"
    APP_KEY="/Library/LaunchAgents/homebrew.mxcl.haproxy.plist"
    CASK="haproxy"
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
