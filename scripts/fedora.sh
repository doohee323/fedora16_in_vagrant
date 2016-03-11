#!/usr/bin/env bash

set -x

# change hosts
echo '' >> /etc/hosts
echo '# for vm' >> /etc/hosts
echo '192.168.82.160 fedora.local.xdn.com' >> /etc/hosts

echo "Reading config...." >&2
source /vagrant/setup.rc

export LC_ALL=C
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

#locale-gen en_US.UTF-8
#dpkg-reconfigure locales

export HOME=/home/vagrant

exit 0

# install httpd

cd /vagrant/scripts
./postinstall.sh

cd /vagrant/scripts
./httpd_install.sh

exit 0
