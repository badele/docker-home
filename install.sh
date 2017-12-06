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
set | egrep "^DH_|DOCKER_HOST" | tee /data/docker/conf/nodes.env

# Search current node installation
selectednode=-1
for nodeidx in ${!DH_SERVICES[*]}
do
  if [ "$DH_MYNODEIP" == "${DH_NODEIP[${nodeidx}]}" ]; then
    selectednode=$nodeidx
  fi
done

if [ $selectednode -eq -1 ];then
  echo "No need install"
  exit 0
fi

# Install all services for this node (host computer)
for serviceconf in ${DH_SERVICES[$selectednode]}
do
  service=$(echo "$serviceconf" | cut -d':' -f1)
  conf=$(echo "$serviceconf" | cut -d':' -f2)
  SRC="`( cd $(dirname \"$0\") && pwd )`"

  print_title "Install $service with '$conf' configuration"
  if [ -e $SRC/services/$service/install.sh ]; then
      $SRC/services/$service/install.sh "$conf" "$1"
  fi
done
