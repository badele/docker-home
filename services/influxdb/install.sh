#!/bin/bash

SRC="`( cd $(dirname \"$0\") && pwd )`"
. $SRC/../../nodes.env
. $SRC/../../lib.sh

if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Init vars
conf=$1
CAPPNAME="DH_CONF_INFLUXDB_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_INFLUXDB_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CBINDIP="DH_CONF_INFLUXDB_${conf^^}_BINDIP" ; BINDIP=${!CBINDIP}
CNETWORK="DH_NETWORK" ; NETWORK=${!CNETWORK}

# interpret node vars
set | egrep "^DH_" > /data/docker/conf/nodes.env

# Get docker image
docker pull $IMGNAME

# Create folder & configuration
mkdir -p /data/docker/$APPNAME/data

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
systemctl daemon-reload
systemctl enable ${APPNAME}-${conf}
systemctl restart ${APPNAME}-${conf}
