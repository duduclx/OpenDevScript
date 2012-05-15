#!/bin/sh

# ps3devubuntu.sh
# 
#
# Created by dudu clx on 15/05/12.
# Copyright 2012 home. All rights reserved.

# Install Software
sudo apt-get install --force-yes nvidia-cg-toolkit
sudo apt-get install --force-yes autoconf 
sudo apt-get install --force-yes automake 
sudo apt-get install --force-yes bison 
sudo apt-get install --force-yes flex 
sudo apt-get install --force-yes texinfo 
sudo apt-get install --force-yes libncurses5-dev 
sudo apt-get install --force-yes gcc 
sudo apt-get install --force-yes g++ 
sudo apt-get install --force-yes make 
sudo apt-get install --force-yes wget 
sudo apt-get install --force-yes libelf-dev 
sudo apt-get install --force-yes python2.7-dev 
sudo apt-get install --force-yes python-dev 
sudo apt-get install --force-yes zlib1g-dev
sudo apt-get install --force-yes libtool 
sudo apt-get install --force-yes git-core 
sudo apt-get install --force-yes libgmp3-dev 
sudo apt-get install --force-yes libssl-dev 
sudo apt-get install --force-yes pkg-config 
sudo apt-get install --force-yes bzip2
clear

export L=/home/$USER/dev
sudo mkdir $L
sudo chown -R $USER $L

# Path
export PS3DEV=$L/ps3dev
export PSL1GHT=$PS3DEV/psl1ght
export PATH=$PATH:$PS3DEV/bin
export PATH=$PATH:$PS3DEV/ppu/bin
export PATH=$PATH:$PS3DEV/spu/bin
 
# Create ps3dev
sudo mkdir $PS3DEV
sudo chown -R $USER $PS3DEV

# Get sources
export BUILDDIR=$L/build
sudo mkdir $BUILDDIR
sudo git clone git://github.com/duduclx/PS3DEV.git $BUILDDIR
sudo chown -R $USER $BUILDDIR

# Install psl1ght
cd $BUILDDIR/ps3toolchain
./toolchain.sh

# Install ps3tools
cd $BUILDDIR/ps3tools
./autogen.sh
./configure --prefix="$PS3DEV/ps3tools"
make
sudo make install

# Install ps3keys
cd /home/$USER
sudo mkdir .ps3
sudo cp $BUILDDIR/ps3keys/. /home/$USER/.ps3
 
# Clean
sudo rm -R $BUILDDIR
clear

# Setup environnement
echo 'export PS3DEV=/home/$USER/dev/ps3dev' >> ~/.bashrc
echo 'export PSL1GHT=$PS3DEV/psl1ght' >> ~/.bashrc
echo 'export PATH="$PATH:$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin"' >> ~/.bashrc
. ~/.bashrc
