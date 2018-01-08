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
source ./$1.env $1
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

# Set Node id
set -a
DH_NODE=node${selectednode}
set +a

# Copy node configurations to temporary file
TPLDEST="${TMPDIR}/${DH_NODE}/${DH_ENV}"
mkdir -p "${TPLDEST}"
rsync -avr --delete --exclude docker-compose.yml --exclude tmp/ "${DH_NODE}/" "${TPLDEST}"

# Replace all variables
for filename in $(find "${TPLDEST}" -type f); do
	envsubst < "$filename" > "${filename}.bak"
	mv "${filename}.bak" "${filename}"
done

# Sync configurations to docker destination
cd "${TPLDEST}"

# Docker don"t support ADD/COPY absolute path
for dirname in $(ls -d */); do
	dirname=${dirname%%/};
	mkdir -p "$SRC/${DH_NODE}/${dirname}/tmp/${DH_ENV}"
	rsync -avr --delete "${dirname}/" "$SRC/${DH_NODE}/${dirname}/tmp/${DH_ENV}"
done

# Launching containers
cd "${SRC}/${DH_NODE}"
docker-compose down
docker-compose config
docker-compose up --build zoneminder
