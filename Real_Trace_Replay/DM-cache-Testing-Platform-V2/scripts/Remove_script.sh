#!/bin/sh

if [ "$1" == "1" ]
then
    lvchange -an /dev/vol_grp/lv1
    lvchange -an /dev/vol_grp/lv2
    lvchange -an /dev/vol_grp/lv3

    lvremove /dev/vol_grp/lv1
    lvremove /dev/vol_grp/lv2
    lvremove /dev/vol_grp/lv3

    vgremove vol_grp
    pvremove /dev/mapper/dm-cache
fi

dmsetup remove dm-cache
dmsetup remove cache
dmsetup remove backend
dmsetup remove meta

#sync
#partprobe
#raid=/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}' | head -n 1`
#wipefs $raid
#dd if=/dev/zero of=$raid bs=1M count=1024
