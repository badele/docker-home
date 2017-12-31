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

# Export nodes variables
set -a
source ./nodes.env $1
set +a

source ./lib.sh

# Search current node installation
selectednode=-1
for nodeidx in ${!DH_NODENAME[*]}
do
  if [ "$(hostname)" == "${DH_NODENAME[${nodeidx}]}" ]; then
    selectednode=$nodeidx
  fi
done

if [ $selectednode -eq -1 ];then
  echo "No install needed here"
  exit 0
fi

# Sync files
cd node${selectednode}
if [ "$DH_ENV" == "public" ]; then
	for dirname in $(ls -d */); do
		dirname=${dirname%%/};
		rsync -avr --update "${dirname}/" "/data/docker/${dirname}-${DH_ENV}"
	done
fi


# Launching containers
docker-compose up -d
