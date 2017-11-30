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
CAPPNAME="DH_CONF_GRAFANA_${conf^^}_APPNAME" ; APPNAME=${!CAPPNAME}
NODENAME="${!CAPPNAME}-${conf}"
CIMGNAME="DH_CONF_GRAFANA_${conf^^}_IMGNAME" ; IMGNAME=${!CIMGNAME}
CINFLUXDB_SERVER="DH_CONF_GRAFANA_${conf^^}_INFLUXDB_SERVER" ; INFLUXDB_SERVER=${!CINFLUXDB_SERVER}

# Get docker image
docker pull ${IMGNAME}

# Create folder & configuration
mkdir -p /data/docker/${NODENAME}/etc
mkdir -p /data/docker/${NODENAME}/lib
mkdir -p /data/docker/${NODENAME}/dashboards

# Copy configuration files
cp $SRC/conf/grafana.ini /data/docker/${NODENAME}/etc/
cp $SRC/dashboards/*.json /data/docker/${NODENAME}/dashboards

# Generate sqlite grafana.db database
if [ ! -e /data/docker/${NODENAME}/lib/grafana.db ]; then
  echo "=> Generate grafana.db"
  replaceVariablesInFile $SRC/conf/grafana.sql /data/docker/${NODENAME}/lib/grafana.sql
  docker run -it -v /data/docker/${NODENAME}/lib:/root/db nouchka/sqlite3 grafana.db ".read grafana.sql"
fi

# Create service
replaceVariablesInFile $SRC/systemd.service /etc/systemd/system/${NODENAME}.service
systemctl daemon-reload
systemctl enable ${NODENAME}
systemctl restart ${NODENAME}
