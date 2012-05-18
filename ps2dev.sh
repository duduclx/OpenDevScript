#!/bin/sh

# ps2dev.sh
# 
#
# Created by dudu clx on 15/05/12.
# Copyright 2012 home. All rights reserved.

# Install software
sudo apt-get install --force-yes gcc
sudo apt-get install --force-yes make 
sudo apt-get install --force-yes patch 
sudo apt-get install --force-yes wget  
sudo apt-get install --force-yes git-core 
sudo apt-get install --force-yes mercurial 
sudo apt-get install --force-yes zlib 
sudo apt-get install --force-yes zlib-dev 
sudo apt-get install --force-yes zlib-devel
sudo apt-get install --force-yes libucl1
sudo apt-get install --force-yes libucl1-dev
sudo apt-get install --force-yes libucl1-devel

clear

# Path
export L=/home/$USER/dev
sudo mkdir $L
sudo chown -R $USER $L

# Environnement
export PS2DEV=$L/ps2dev
export PATH=$PATH:$PS2DEV/bin
export PATH=$PATH:$PS2DEV/ee/bin
export PATH=$PATH:$PS2DEV/iop/bin
export PATH=$PATH:$PS2DEV/dvp/bin
export PS2SDK=$PS2DEV/ps2sdk
export PATH=$PATH:$PS2SDK/bin
export PS2ETH=$PS2DEV/ps2eth
export GSKIT=$PS2DEV/gsKit
export LANG=C
export LC_ALL=C

# Go to Directory
sudo mkdir $PS2DEV
sudo chown -R $USER $PS2DEV
cd $PS2DEV

# Get sources
export BUILDDIR=$L/build
sudo mkdir $BUILDDIR
sudo git clone git://github.com/duduclx/PS2DEV.git $BUILDDIR
sudo chown -R $USER $BUILDDIR

# Install ps2toolchain
cd $BUILDDIR/ps2toolchain
./toolchain.sh
clear

#compilation de ps2eth
cd $BUILDDIR/ps2eth
make
# clear
sleep 5

#compilation de gskit
cd $BUILDDIR/gsKit
make
# clear
sleep 5

#compilation de zlib
cd ..
cp -R ps2sdk-ports/zlib ./
cd zlib
make && make install  
# clear
sleep 5

#compilation de libpng
cd $BUILDDIR/ps2sdk-ports/libpng
make && make install
# clear
sleep 5

#compilation de libjpeg
cd $BUILDDIR/ps2sdk-ports/libjpeg
make && make install
# clear
sleep 5

#compilation de ps2-packer
cd $BUILDDIR/ps2-packer
make
make install
# clear
sleep 5

# Clean
#sudo rm -R $BUILDDIR
#clear