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

CAPPNAME="DH_CONF_GRAFANA_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_GRAFANA_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CINFLUXDB_SERVER="DH_CONF_GRAFANA_${conf^^}_INFLUXDB_SERVER" ; INFLUXDB_SERVER=${!CINFLUXDB_SERVER}

# Get docker image
docker -H 0.0.0.0:2375 pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}-${ENVIRONMENT}/etc
mkdir -p /data/docker/${NODENAME}-${ENVIRONMENT}/lib
mkdir -p /data/docker/${NODENAME}-${ENVIRONMENT}/dashboards

# Copy configuration files
cp $SRC/conf/grafana.ini /data/docker/${NODENAME}-${ENVIRONMENT}/etc/
cp $SRC/dashboards/*.json /data/docker/${NODENAME}-${ENVIRONMENT}/dashboards

# Generate sqlite grafana.db database
if [ ! -e /data/docker/${NODENAME}-${ENVIRONMENT}/lib/grafana.db ]; then
  echo "=> Generate grafana.db"
  replaceVariablesInFile $SRC/conf/grafana.sql /data/docker/${NODENAME}-${ENVIRONMENT}/lib/grafana.sql
  docker -H 0.0.0.0:2375  run --rm -v /data/docker/${NODENAME}-${ENVIRONMENT}/lib:/root/db nouchka/sqlite3 grafana.db ".read grafana.sql"
fi

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
