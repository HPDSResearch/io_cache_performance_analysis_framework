#!/bin/sh

#set -x
#Remove cache(OpenCAS)
dsk=/dev/"cas1-1"
#raid=/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}' | head -n 1`

if [ "$1" == "1" ]
then
    lvchange -an /dev/vol_grp/lv1
    lvchange -an /dev/vol_grp/lv2
    lvchange -an /dev/vol_grp/lv3

    lvremove /dev/vol_grp/lv1
    lvremove /dev/vol_grp/lv2
    lvremove /dev/vol_grp/lv3

    vgchange -an vol_grp
    vgreduce vol_grp $dsk
    vgremove vol_grp
    pvremove $dsk
    pvdisplay $dsk
fi
casadm -L |tee -a ../outputs/test_log.txt
casadm -T -i 1 -n 2>> ../outputs/test_log.txt
casadm -L |tee -a ../outputs/test_log.txt
lsblk >> ../outputs/test_log.txt
#sync
#partprobe
#wipefs $raid
#dd if=/dev/zero of=$raid bs=1M count=1024
