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
export PSL1GHT=$PS3DEV
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
chmod a+x autogen.sh
sh ./autogen.sh
sh ./configure --prefix="$PS3DEV"
make
sudo make install

# Install libopf for OpenPs3Ftp
cd $BUILDDIR/libs/libopf
make
sudo make install

# Install rsxgl
cd $BUILDDIR/libs/rsxgl
./configure
make
sudo make install

# Install sdl-libs
cd $BUILDDIR/libs/sdl-libs
chmod a+x make_SDL_Libs.sh
./make_SDL_Libs.sh

# Install ps3soundlib
cd $BUILDDIR/libs/ps3soundlib
make

# Install tiny3D
cd $BUILDDIR/libs/tiny3d
make

# Install ps3keys
sudo mkdir /home/$USER/.ps3
sudo cp $BUILDDIR/ps3keys/* /home/$USER/.ps3

# Install some samples
mkdir $PS3DEV/samples
sudo chown -R $USER $PS3DEV/samples
sudo cp -R $BUILDDIR/psl1ght/samples $PS3DEV

# Install some sources
sudo mkdir $PS3DEV/sources
sudo chown -R $USER $PS3DEV/sources
sudo cp -R $BUILDDIR/sources $PS3DEV
 
# Clean
sudo chown -R $USER $PS3DEV
sudo rm -R $BUILDDIR
clear

# End
echo "ps3dev, psl1ght v2 installed with success."
echo "make sure to setup environnement before compiling."
echo "export PS3DEV=/home/$USER/dev/ps3dev
export PSL1GHT=$PS3DEV
export PATH=$PATH:$PS3DEV/bin
export PATH=$PATH:$PS3DEV/ppu/bin
export PATH=$PATH:$PS3DEV/spu/bin"
echo "all credits to all developers".