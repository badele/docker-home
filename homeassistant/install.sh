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
cp $SRC/conf/* /data/docker/$APPNAME/data/

# Overide private configuration
if [ "$1" != "public" ]; then
  rsync -avr $SRC/../PRIVATE/$APPNAME/conf/ /data/docker/$APPNAME/data/
fi

# Create service
cp $SRC/systemd.service /etc/systemd/system/$APPNAME.service
systemctl daemon-reload
systemctl enable $APPNAME
systemctl restart $APPNAME
