#!/bin/bash

SRC="`( cd $(dirname \"$0\") && pwd )`"
source $SRC/db.env

if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Get docker image
docker pull $IMGNAME

# Create folder & configuration
mkdir -p /data/docker/$APPNAME/data
mkdir -p /data/docker/$APPNAME/conf
cp $SRC/db.env /data/docker/$APPNAME/conf/

# Create service
cp $SRC/systemd.service /etc/systemd/system/$APPNAME.service
systemctl daemon-reload
systemctl enable $APPNAME
systemctl restart $APPNAME
