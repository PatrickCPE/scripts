#!/bin/sh -x

# Prerequisites:
apt-get install -y git help2man perl python3 make autoconf g++ flex bison ccache
apt-get install -y libgoogle-perftools-dev numactl perl-doc
apt-get install libgz  # Non-Ubuntu (ignore if gives error)
apt-get install -y libfl2  # Ubuntu only (ignore if gives error)
apt-get install -y libfl-dev  # Ubuntu only (ignore if gives error)
apt-get install -y zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)

mkdir /tmp/verilator_tmp
git clone https://github.com/verilator/verilator /tmp/verilator_tmp   # Only first time

# Every time you need to build:
unset VERILATOR_ROOT  # For bash
cd /tmp/verilator_tmp
git pull         # Make sure git repository is up-to-date
git checkout master      # Use development branch (e.g. recent bug fixes)

autoconf         # Create ./configure script
./configure      # Configure and create Makefile
make -j `nproc`  # Build Verilator itself (if error, try just 'make')
make install

cd ~
rm /tmp/verilator_tmp/ -rf
