#!/bin/bash

APP="grafana"
SRC="`( cd $(dirname \"$0\") && pwd )`"

if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Create folder & configuration
mkdir -p /data/docker/$APP/data

# Create service
cp $SRC/systemd.service /etc/systemd/system/$APP.service
systemctl daemon-reload
systemctl enable $APP
systemctl restart $APP
