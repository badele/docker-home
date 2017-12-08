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

CAPPNAME="DH_CONF_INFLUXDB_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_INFLUXDB_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}

# Get docker image
docker -H 0.0.0.0:2375 pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}-${ENVIRONMENT}/data

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
