#!/bin/sh -x

# Make and install mcy formal tool and setup dependencies

apt-get install -y cmake qtbase5-dev qtdeclarative5-dev

mkdir /tmp/mcy_tmp
git clone https://github.com/YosysHQ/mcy.git /tmp/mcy_tmp
cd /tmp/mcy_tmp
make -j `nproc`
make install

cd ~/
rm /tmp/mcy_tmp -rf
