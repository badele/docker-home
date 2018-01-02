#!/bin/bash

TMPDIR="/tmp/docker-home"
SRC="`( cd $(dirname \"$0\") && pwd )`"

# The script must be running in root
if [ "$(whoami)" != "root" ] ; then
   echo "Please run in root"
   exit 0
fi

# Select docker environment
if [ "$1" == "" ]; then
    echo "Usage:"
    echo "$0 environment"
    echo "ex: $0 private/public"
    exit 0
fi

# Export nodes variables
set -a
source ./nodes.env $1
set +a

#source ./lib.sh

# Search node installation
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
ROOTNODE=node${selectednode}

# Copy node configurations to temporary file
mkdir -p "$TMPDIR"
rsync -avr --delete --exclude docker-compose.yml "${ROOTNODE}/" "${TMPDIR}/${ROOTNODE}"

# Replace all variables
for filename in $(find "${TMPDIR}/${ROOTNODE}" -type f); do
	envsubst < "$filename" > "${filename}.bak"
	mv "${filename}.bak" "${filename}"
done

# Sync configurations to docker destination
cd "${TMPDIR}/${ROOTNODE}"
if [ "$DH_ENV" == "public" ]; then
	cd "${TMPDIR}/${ROOTNODE}"
fi
for dirname in $(ls -d */); do
	dirname=${dirname%%/};
	mkdir -p "/data/docker/${dirname}-${DH_ENV}"
	rsync -avr --update "${dirname}/" "/data/docker/${dirname}-${DH_ENV}"
done

# Launching containers
cd "${SRC}/${ROOTNODE}"
docker-compose down
docker-compose up -d
