#!/bin/sh -x

# Install latest verion of Yosys from github alongside dependencies

apt-get install -y build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev

mkdir /tmp/yosys_tmp
git clone https://github.com/YosysHQ/yosys.git /tmp/yosys_tmp
cd /tmp/yosys_tmp
make config-gcc
make -j `nproc`
make install

cd ~
rm /tmp/yosys_tmp -rf
