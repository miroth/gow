#!/bin/bash

set -xe

sudo docker build -t zwg.arch_base arch_base/build/
sudo docker build -t zwg.arch_app arch_app/build/
sudo docker build -t zwg.arch_steam arch_steam/build/
sudo docker build -t zwg.arch_heroic arch_heroic/build/
sudo docker build -t zwg.fedora_xfce zwg_xfce/build-fedora
