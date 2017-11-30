#!/bin/bash

# The script must be running in root
if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Load lib and environment vars
SRC="`( cd $(dirname \"$0\") && pwd )`"
source /data/docker/conf/nodes.env
source $SRC/../../lib.sh

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
