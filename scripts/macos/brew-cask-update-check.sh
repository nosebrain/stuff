#!/bin/bash

brew update

APPS_TO_UPDATE=""

echo "Checking for updates..."
IFS=$'\n'
for APP_VERSION in `brew cask list --versions`
do
#  echo $APP_VERSION
  INSTALLED_VERSION=${APP_VERSION##* }
  APP=`echo -n "${APP_VERSION}" | cut -d" " -f1`
  CURRENT_APP_VERSION=`brew cask info $APP | head -n 1`
  CURRENT_VERSION=${CURRENT_APP_VERSION##*: }
  CURRENT_VERSION=${CURRENT_VERSION%%" (auto_updates)"}
  if [ "$CURRENT_VERSION" != "$INSTALLED_VERSION" ]; then
    echo "$APP $INSTALLED_VERSION -> $CURRENT_VERSION"
    APPS_TO_UPDATE="${APPS_TO_UPDATE} $APP"
  fi
done

echo " Done"

if [[ -z "$APPS_TO_UPDATE" ]]; then
   echo "No updates found"
   exit 0
fi

echo "The following apps will be upgraded:"
echo $APPS_TO_UPDATE | sed 's/^/  /'
read -r -p "Do you want to continue? [Y/n] " response
case $response in
  [yY]|"")
  for APP in `echo $APPS_TO_UPDATE`; do
    echo -n "upgrading $APP..."
    ./brew-cask-update.sh $APP > /dev/null 2>&1
    echo " Done"
  done
  echo -n "cleaning up..."
  brew cleanup
  brew cask cleanup
  echo " Done"
  ;;
  *)
  ;;
esac

# brew cleanup --force -s
# rm -rf $(brew --cache)