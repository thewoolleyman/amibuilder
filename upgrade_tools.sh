#!/bin/sh

ssh -i $keypair \
  ubuntu@$host \
'export DEBIAN_FRONTEND=noninteractive && \
echo "deb http://ppa.launchpad.net/ubuntu-on-ec2/ec2-tools/ubuntu karmic main" | \
  sudo tee /etc/apt/sources.list.d/ubuntu-on-ec2-ec2-tools.list && \
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9EE6D873 && \
sudo apt-get update && \
sudo -E apt-get dist-upgrade -y && \
sudo -E apt-get install -y ec2-api-tools'