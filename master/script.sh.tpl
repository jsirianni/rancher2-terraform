#!/bin/bash

sudo apt-get update
sudo apt-get install docker.io -y >> /tmp/setup.log

sudo systemctl enable docker >> /tmp/setup.log
sudo systemctl start docker >> /tmp/setup.log


if [ "${letsencrypt}" = "true" ] ; then

    echo "using domain ${fqdn}" >> /tmp/setup.log
    sudo docker run \
        -d \
        --restart=unless-stopped \
        -p 80:80 \
        -p 443:443 rancher/rancher:stable \
        --acme-domain ${fqdn}

else

    echo "not using letsencrypt" >> /tmp/setup.log
    sudo docker run \
        -d \
        --restart=unless-stopped \
        -p 80:80 \
        -p 443:443 rancher/rancher:stable

fi
