#!/bin/sh

# pspdev.sh
# 
#
# Created by dudu clx on 15/05/12.
# Copyright 2012 home. All rights reserved.

# Install software
sudo apt-get install --force-yes build-essential
sudo apt-get install --force-yes autoconf 
sudo apt-get install --force-yes automake 
sudo apt-get install --force-yes bison  
sudo apt-get install --force-yes flex 
sudo apt-get install --force-yes libncurses5-dev 
sudo apt-get install --force-yes libncurses5-devel
sudo apt-get install --force-yes libreadline-dev 
sudo apt-get install --force-yes libreadline-devel
sudo apt-get install --force-yes libusb-dev
sudo apt-get install --force-yes libusb-devel
sudo apt-get install --force-yes texinfo
sudo apt-get install --force-yes libgmp3-dev
sudo apt-get install --force-yes libgmp3-devel
sudo apt-get install --force-yes libmpfr-dev
sudo apt-get install --force-yes libmpfr-devel
sudo apt-get install --force-yes libmpc-dev
sudo apt-get install --force-yes libmpc-devel
sudo apt-get install --force-yes libelf-dev
sudo apt-get install --force-yes libelf-devel
sudo apt-get install --force-yes subversion
sudo apt-get install --force-yes git
sudo apt-get install --force-yes g++
sudo apt-get install --force-yes gcc
sudo apt-get install --force-yes wget
clear

# Path
export L=/home/$USER/dev
sudo mkdir $L
sudo chown -R $USER $L

# Environnement
export PSPDEV=$L/pspdev
export PSPSDK=$PSPDEV/psp/sdk
export PATH=$PATH:$PSPDEV/bin:$PSPSDK/bin

# Go to Directory
sudo mkdir $PSPDEV
sudo chown -R $USER $PSPDEV
cd $PSPDEV

# Get sources
export BUILDDIR=$L/build
sudo mkdir $BUILDDIR
sudo git clone git://github.com/duduclx/PSPDEV.git $BUILDDIR
sudo chown -R $USER $BUILDDIR

# Install psptoolchain
cd $BUILDDIR/psptoolchain
./toolchain.sh

# Install prxtool
cd $BUILDDIR/prxtool
./bootstrap
./configure prefix="$PSPDEV"
make
sudo make install
sudo make install all

# Install psp-ports
# cd $BUILDDIR/psp-ports
# buildallports.sh
# clear

# Move Samples
mv $PSPDEV/psp/sdk/samples $PSPDEV

# Clean
sudo chown -R $USER $PSPDEV
sudo rm -R $BUILDDIR
clear