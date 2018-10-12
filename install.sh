#!/bin/bash

TMPDIR="/tmp/docker-home"
SRC="$( (cd $(dirname "$0") && pwd))"

# The script must be running in root
if [ "$(whoami)" != "root" ]; then
	echo "Please run in root"
	exit 0
fi

# Select docker environment
if [ "$2" == "" ]; then
	echo "Usage:"
	echo "$0 environment nodename"
	echo "ex: $0 private/public fullstack"
	exit 0
fi

if [ ! -e "$SRC/$2" ]; then
	echo "$2 node not exist"
	exit 1
fi

# Export nodes variables
set -a
source ./$1.env $1
set +a
export DH_NODE="$2"

# Root remove protection
if [ "$(realpath $DH_DSTDOCKER)" = "/" ]; then
	echo "Cannot store docker images in / folder"
	exit 1
fi

# Create DH_DSTDOCKER Directory
mkdir -p $DH_DSTDOCKER

# Copy node configurations to temporary file
TPLDEST="${TMPDIR}/${DH_NODE}/${DH_ENV}"
mkdir -p "${TPLDEST}"
rsync -avr --delete "${DH_NODE}/" "${TPLDEST}"

# Replace all variables
for filename in $(find "${TPLDEST}" -type f); do
	envsubst <"$filename" >"${filename}.bak"
	mv "${filename}.bak" "${filename}"
done

# Sync configurations to docker destination
mkdir -p "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}"
rsync -avr --ignore-existing "${TPLDEST}/" "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/"


# Launching containers
docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" down
docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" config
#docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" up --build zoneminder
docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" build

# Create public_default docker network
docker network ls | grep public_default > /dev/null
if [ $? -eq 1 ]; then
	docker network create public_default
fi
docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" create
docker-compose -f "${DH_DSTDOCKER}/${DH_NODE}/${DH_ENV}/docker-compose.yml" start