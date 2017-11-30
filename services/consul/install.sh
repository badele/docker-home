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
CAPPNAME="DH_CONF_CONSUL_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_CONSUL_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CBINDIP="DH_CONF_CONSUL_${conf^^}_BINDIP" ; BINDIP=${!CBINDIP}

# Get docker image
docker pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
