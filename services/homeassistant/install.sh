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
mkdir -p /data/docker/${APPNAME}/data
mkdir -p /data/docker/${APPNAME}/conf
cp $SRC/conf/* /data/docker/${APPNAME}/data/

# interpret node vars
set | egrep "^DH_" > /data/docker/conf/nodes.env

# Overide private configuration
if [ "$2" != "public" ]; then
  rsync -avr $SRC/../../PRIVATE/${APPNAME}/conf/ /data/docker/${APPNAME}/data/
fi

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
replaceVariablesInFile /data/docker/${APPNAME}/data/configuration.yaml /data/docker/${APPNAME}/data/configuration.yaml

systemctl daemon-reload
systemctl enable ${APPNAME}-${conf}
systemctl restart ${APPNAME}-${conf}
