#!/bin/sh -x

# Make and install mcy formal tool and setup dependencies

apt-get install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev \
	libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf curl libgtk-3-dev libgnutls28-dev

mkdir /tmp/emacs_tmp
curl http://ftp.gnu.org/gnu/emacs/emacs-28.2.tar.xz -o /tmp/emacs_tmp/emacs-28.2.tar.xz
cd /tmp/emacs_tmp
tar -xf ./emacs-28.2.tar.xz
cd emacs-28.2
mkdir build
cd build
../configure
make -j `nproc`
make install

cd ~/
rm /tmp/emacs_tmp -rf
