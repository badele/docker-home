#!/bin/bash

# The script must be running in root
if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

if [ "$1" == "" ]; then
    echo "Usage:"
    echo "$0 environment"
    echo "ex: $0 private/public"
    exit 0
fi


# Load lib and environment vars
SRC="`( cd $(dirname \"$0\") && pwd )`"
source ./nodes.env
source ./lib.sh

# Search current node installation

selectednode=-1
for nodeidx in ${!DH_NODENAME[*]}
do
  echo "## $(hostname)" == "${DH_NODENAME[${nodeidx}]}"
  if [ "$(hostname)" == "${DH_NODENAME[${nodeidx}]}" ]; then
    selectednode=$nodeidx
  fi
done

if [ $selectednode -eq -1 ];then
  echo "No need install"
  exit 0
fi

echo "Verify node${selectednode} docker compose configuration"
cd node${selectednode}
docker-compose config
