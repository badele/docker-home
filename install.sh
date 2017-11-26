#!/bin/bash

SRC="`( cd $(dirname \"$0\") && pwd )`"

# if [ "$1" == "" ]; then
#   echo "Usage:"
#   echo "$0 NODEID [public]"
#   exit 1
# fi

source ./nodes.env
source ./lib.sh

# Search install all service for my nodeip
for nodeidx in ${!DH_SERVICES[*]}
do
  NODEIP=${DH_NODEIP[$nodeidx]}
  if [ "$NODEIP" != "" ]; then
    for serviceconf in ${DH_SERVICES[$nodeidx]}
    do
      service=$(echo "$serviceconf" | cut -d':' -f1)
      conf=$(echo "$serviceconf" | cut -d':' -f2)
      SRC="`( cd $(dirname \"$0\") && pwd )`"

      print_title "Install $service with $conf configuration"
      if [ -e $SRC/services/$service/install.sh ]; then
          $SRC/services/$service/install.sh "$conf" "$1"
      fi
    done
  fi
done
