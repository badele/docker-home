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

# Init vars
conf=$1
CAPPNAME="DH_CONF_HOMEASSISTANT_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_HOMEASSISTANT_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CBINDIP="DH_CONF_HOMEASSISTANT_${conf^^}_BINDIP" ; BINDIP=${!CBINDIP}
CNETWORK="DH_NETWORK" ; NETWORK=${!CNETWORK}
CINFLUXDB_SERVER="DH_CONF_HOMEASSISTANT_HA_INFLUXDB_SERVER" ; INFLUXDB_SERVER=${!CINFLUXDB_SERVER}

# Get docker image
docker -H 0.0.0.0:2375 pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}/data
cp $SRC/conf/default/* /data/docker/${NODENAME}/data/

# Overide private configuration
if [ "$2" != "public" ]; then
  rsync -avr $SRC/../../PRIVATE/${NODENAME}/conf/ /data/docker/${NODENAME}/data/
fi

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
replaceVariablesInFile /data/docker/${NODENAME}/data/configuration.yaml /data/docker/${NODENAME}/data/configuration.yaml

systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
