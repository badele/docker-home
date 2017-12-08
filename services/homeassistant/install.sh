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
ENVIRONMENT=$2

CAPPNAME="DH_CONF_HOMEASSISTANT_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_HOMEASSISTANT_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CBINDIP="DH_CONF_HOMEASSISTANT_${conf^^}_BINDIP" ; BINDIP=${!CBINDIP}
CNETWORK="DH_NETWORK" ; NETWORK=${!CNETWORK}
CINFLUXDB_SERVER="DH_CONF_HOMEASSISTANT_${conf^^}_INFLUXDB_SERVER" ; INFLUXDB_SERVER=${!CINFLUXDB_SERVER}

# Get docker image
docker -H 0.0.0.0:2375 pull ${IMGNAME}

# Copy configuration
replaceVariablesFromFolder $SRC/conf/default /data/docker/${NODENAME}-${ENVIRONMENT}/data

# Overide private configuration
if [ "$opts" != "public" ]; then
    if [ -e $SRC/../../PRIVATE/${NODENAME}/conf ]; then
        replaceVariablesFromFolder $SRC/../../PRIVATE/${NODENAME}/conf /data/docker/${NODENAME}-${ENVIRONMENT}/data
    fi
    #rsync -avr $SRC/../../PRIVATE/${NODENAME}/conf/ /data/docker/${NODENAME}/data/
fi

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service

systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
