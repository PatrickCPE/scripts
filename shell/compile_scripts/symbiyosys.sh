#!/bin/sh -x

# Install latest verion of SymbiYosys from github alongside dependencies

mkdir /tmp/sby_tmp
git clone https://github.com/YosysHQ/sby /tmp/sby_tmp
cd /tmp/sby_tmp
make -j `nproc`
make install

mkdir /tmp/boolector_tmp
git clone https://github.com/boolector/boolector /tmp/boolector_tmp
cd /tmp/boolector_tmp
./contrib/setup-btor2tools.sh
./contrib/setup-lingeling.sh
./configure.sh
make -C build -j `nproc`
cp build/bin/{boolector,btor*} /usr/local/bin/
cp deps/btor2tools/bin/btorsim /usr/local/bin/

mkdir /tmp/btor_tools_tmp
git clone https://github.com/Boolector/btor2tools.git /tmp/btor_tools_tmp
cd /tmp/btor_tools_tmp
./configure.sh
cd build
make
make install


cd ~
rm /tmp/sby_tmp -rf
rm /tmp/boolector_tmp -rf
rm /tmp/btor_tools_tmp -rf
