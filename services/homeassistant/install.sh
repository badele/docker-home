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
CAPPNAME="DH_CONF_HOMEASSISTANT_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_HOMEASSISTANT_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CBINDIP="DH_CONF_HOMEASSISTANT_${conf^^}_BINDIP" ; BINDIP=${!CBINDIP}
CNETWORK="DH_NETWORK" ; NETWORK=${!CNETWORK}

# Get docker image
docker pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}/data
mkdir -p /data/docker/${NODENAME}/conf
cp $SRC/conf/* /data/docker/${NODENAME}/data/

# interpret node vars
set | egrep "^DH_" > /data/docker/conf/nodes.env

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
