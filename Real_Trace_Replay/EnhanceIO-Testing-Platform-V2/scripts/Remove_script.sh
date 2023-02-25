#!/bin/sh
#raid=/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}' | head -n 1`
#lvchange -an /dev/vol_grp/lv1
#lvchange -an /dev/vol_grp/lv2
#lvchange -an /dev/vol_grp/lv3

#lvremove /dev/vol_grp/lv1
#lvremove /dev/vol_grp/lv2
#lvremove /dev/vol_grp/lv3

#vgremove vol_grp
#pvremove $raid

#Removing Enhanceio
eio_cli delete -c En_cache
./ramdisk_delete.sh

#sync
#partprobe
#wipefs $raid
#dd if=/dev/zero of=$raid bs=1M count=1024
