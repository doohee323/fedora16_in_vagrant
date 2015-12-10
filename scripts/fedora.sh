#!/usr/bin/env bash

# Get root up in here
sudo su

set -x

# change hosts
echo '' >> /etc/hosts
echo '# for vm' >> /etc/hosts
echo '192.168.82.160 fedora.local.xdn.com' >> /etc/hosts
echo '192.168.82.194 judgeredis.local.xdn.com' >> /etc/hosts

echo "Reading config...." >&2
source /vagrant/setup.rc

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

PROJ_NAME=fedora
HOME=/home/vagrant


