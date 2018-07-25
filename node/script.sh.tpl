#!/bin/bash

sudo apt-get update
sudo apt-get install docker.io -y

sudo systemctl enable docker
sudo systemctl start docker

sudo docker run \
    -d \
    --privileged \
    --restart=unless-stopped \
    --net=host \
    -v /etc/kubernetes:/etc/kubernetes \
    -v /var/run:/var/run rancher/rancher-agent:v2.0.6 \
    --server https://${fqdn} \
    --token ${token} \
    ${roles} \
    ${labels}
