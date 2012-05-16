#!/bin/sh

# ps2opl.sh
# 
#
# Created by dudu clx on 15/05/12.
# Copyright 2012 home. All rights reserved.

# Setup environnement
export PS2DEV=/home/$USER/dev/ps2dev
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

# Compile  Open-PS2-Loader
cd $PS2DEV
hg clone http://bitbucket.org/ifcaro/open-ps2-loader/
cd open-ps2-loader
make
clear

# Compile tools
cd $PS2DEV/open-ps2-loader/pc
make
clear

echo "open-ps2-loader compiled (opl.elf) into '/home/$USER/dev/ps2dev/open-ps2-loader'" 
echo "iso2opl, opl2iso compiled into '/home/$USER/dev/ps2dev/open-ps2-loader/pc'"