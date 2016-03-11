#!/usr/bin/env bash

set -x

#export TMP=/root/tmp
export TMP=/home/vagrant/tmp
mkdir -p $TMP

# 0) zlib
cd $TMP
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xvfz zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make
sudo make install

# 1) openssh
sudo rm -Rf /usr/lib64/openssl /usr/local/openssl /usr/share/man/man1/openssl.1ssl.gz
sudo rm -Rf /usr/local/ssl/bin/openssl /usr/local/ssl/include/openssl /usr/local/include/openssl
sudo rm -Rf /usr/share/bash-completion/openssl /usr/lib/ruby/1.8/openssl
sudo rm -Rf /usr/bin/openssl /usr/include/openssl

cd $TMP
wget https://openssl.org/source/openssl-1.0.2g.tar.gz
tar xvfz openssl-1.0.2g.tar.gz
cd openssl-1.0.2g
./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic
make
sudo make install
export PATH=$PATH:/usr/bin/openssl:/usr/include/openssl

# 2) apr
cd $TMP
# http://www.linuxfromscratch.org/blfs/view/svn/general/apr.html
wget http://archive.apache.org/dist/apr/apr-1.5.2.tar.bz2
bzip2 -dk apr-1.5.2.tar.bz2
tar xvf apr-1.5.2.tar.bz2
cd apr-1.5.2
#vi configure # error fixed: $RM "$cfgfile" -> $RM -f "$cfgfile"
sed -ie 's/$RM "$cfgfile"/$RM -f "$cfgfile"/g' $TMP/apr-1.5.2/configure
./configure --prefix=/usr --disable-static --with-installbuilddir=/usr/share/apr-1/build
make
sudo make install

# 3) apr-util
cd $TMP
# http://www.linuxfromscratch.org/blfs/view/svn/general/apr-util.html
wget http://apache.osuosl.org/apr/apr-util-1.5.4.tar.gz
tar xvfz apr-util-1.5.4.tar.gz
cd apr-util-1.5.4
./configure --prefix=/usr --with-apr=/usr --with-gdbm=/usr --with-openssl=/usr --with-crypto
make
sudo make install

# 4) pcre
cd $TMP
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
tar xvfz pcre-8.38.tar.gz
cd pcre-8.38
./configure --prefix=/usr                     \
            --docdir=/usr/share/doc/pcre-8.38 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --disable-static --disable-cpp
make
sudo make install

# 5) build httpd
cd $TMP
wget https://archive.apache.org/dist/httpd/httpd-2.4.18.tar.bz2
bzip2 -dk httpd-2.4.18.tar.bz2
tar xvf httpd-2.4.18.tar
cd httpd-2.4.18
./configure --prefix=/usr/local/httpd --with-apr=/usr --with-apr-util=/usr --with-pcre=/usr

make
sudo make install
ls -al /usr/local/httpd/bin

exit 0
