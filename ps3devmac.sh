#!/bin/sh

# ps3devmac.sh
# 
#
# Created by dudu clx on 15/05/12.
# Copyright 2012 home. All rights reserved.

## Create PATH
export L=/Users/$USER/dev
sudo mkdir $L
sudo chown -R $USER $L

## Build ps3dev dir.
sudo mkdir $L/ps3dev

## Set up the environment.
export PS3DEV=$L/ps3dev
export PSL1GHT=$PS3DEV/psl1ght
sudo chown -R $USER $PS3DEV

## set up the build dir.
export BUILDDIR=$L/build
sudo mkdir $BUILDDIR
sudo chown -R $USER $BUILDDIR 

## Set up the path.
export PATH=$PATH:$PS3DEV/bin
export PATH=$PATH:$PS3DEV/ppu/bin
export PATH=$PATH:$PS3DEV/spu/bin

## Build port dependencies.
sudo port -f clean installed
sudo port install autoconf +universal
sudo port install bison +universal
sudo port install flex +universal
sudo port install texinfo +universal
sudo port install wget +univeral
sudo port install libelf +universal 
sudo port install python27 +universal
sudo port select --set python python27
sudo port install libtool +universal 
sudo port install gcc45 +universal
sudo port install nano
sudo port install gzip +universal

## Build dependencies
cd $BUILDDIR

### Build GMP.
wget ftp://ftp.gnu.org/gnu/gmp/gmp-5.0.1.tar.bz2
tar -xjvf gmp-5.0.1.tar.bz2
cd gmp-5.0.1
aclocal
./configure --enable-cxx --enable-mpbsd --enable-static --with-gnu-ld
make
make check
sudo make install
cd ..

### Build PKG-CONFIG.
wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.25.tar.gz
tar -xzvf pkg-config-0.25.tar.gz
cd pkg-config-0.25
aclocal
./configure
make
make check
sudo make install
cd ..
clear

### Build AUTOMAKE.
wget http://ftp.gnu.org/gnu/automake/automake-1.10.tar.bz2
tar -xjvf automake-1.10.tar.bz2
cd automake-1.10
./configure
make
sudo make install
cd ..
clear

## Setup port.
port -v selfupdate
port upgrade outdated
port sync

## Install PS3TOOLS.
git clone git@github.com:duduclx/ps3tools.git
cd ps3tools
./autogen.sh
./configure --prefix="$PS3DEV/ps3tools"
make
sudo make install
cd ..
clear

## Install TOOLCHAIN-psl1ght-ps3libraries.
git clone git@github.com:duduclx/ps3toolchain_mac.git
cd ps3toolchain_mac
./toolchain.sh
cd ..
clear

## Cleaning build dir
cd $L
sudo rm -R build

## Install Keys.
### Exit Sudo.
exit
### make .ps3 dir.
cd ~
sudo mkdir .ps3
### copy key to .ps3 dir
git clone git@github.com:duduclx/ps3keys.git
ditto ps3keys ~/.ps3
sudo rm -R ps3keys