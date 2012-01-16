#!/bin/sh

# mb.sh
# Untitled
#
# Created by Eduard Sionov on 1/14/11.
# Copyright 2011 __MyCompanyName__. All rights reserved.

echo $1
fdisk -e $1 <<EOF
flag 1
write
yes
quit
EOF