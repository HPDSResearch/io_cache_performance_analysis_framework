#!/bin/sh
#set -x
#Creating Enhanceio
./ramdisk_create.sh
frontend='/dev/ram1'
#MANUAL SETTING: select the proper backend device
# the backend block device size is important [following the real trace type]
# VDI: At least 5TB backend
# TPCC: At least 400GB backend
# MS Exchange: At least 1.5TB backend
backend=/dev/?
# | sed 's/^../\/dev\//g'
eio_cli create -d $backend -s $frontend  -p lru -m wb -b 4096 -c En_cache

#MANUAL SETTING: UNCOMMENT ALL BELOW LINES FOR MS EXCHANGE TRACES ONLY
#pvcreate $backend
#vgcreate vol_grp $backend
#lvcreate -L 480G -n lv1 vol_grp
#lvcreate -L 480G -n lv2 vol_grp
#lvcreate -L 480G -n lv3 vol_grp
