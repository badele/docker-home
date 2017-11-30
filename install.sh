#!/bin/bash

# The script must be running in root
if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Load lib and environment vars
SRC="`( cd $(dirname \"$0\") && pwd )`"
source ./nodes.env
source ./lib.sh

# Compute node vars
mkdir -p /data/docker/conf
set | egrep "^DH_" | tee /data/docker/conf/nodes.env

# Install all services for node (host computer)
for nodeidx in ${!DH_SERVICES[*]}
do
  NODEIP=${DH_NODEIP[$nodeidx]}
  if [ "$NODEIP" != "" ]; then
    for serviceconf in ${DH_SERVICES[$nodeidx]}
    do
      service=$(echo "$serviceconf" | cut -d':' -f1)
      conf=$(echo "$serviceconf" | cut -d':' -f2)
      SRC="`( cd $(dirname \"$0\") && pwd )`"

      print_title "Install $service with '$conf' configuration"
      if [ -e $SRC/services/$service/install.sh ]; then
          $SRC/services/$service/install.sh "$conf" "$1"
      fi
    done
  fi
done
