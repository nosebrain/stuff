#!/bin/sh

TOMCAT_BASE_DIR=/share/lib/tomcat
SU=/opt/bin/su
NOHUP=/opt/bin/nohup
USER=app

COMMAND="$NOHUP $TOMCAT_BASE_DIR/bin/startup.sh"
if [ -n "$USER" ]; then
  COMMAND="$SU $USER -s $COMMAND"
fi

$COMMAND