#!/bin/bash

function sleeping() {
    echo "##########################################################"
    echo "# Sleep during ${1}s for $2 service"
    echo "##########################################################"
    sleep 10
}

sudo ./install.sh public consul
sleeping 10 "Consul"
sudo ./install.sh public emqttd
