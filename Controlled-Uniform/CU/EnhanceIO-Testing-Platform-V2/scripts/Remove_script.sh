#!/bin/sh
#raid=/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}' | head -n 1`

#Removing Enhanceio
eio_cli delete -c En_cache
./ramdisk_delete.sh

#sync
#partprobe
#wipefs $raid
#dd if=/dev/zero of=$raid bs=1M count=1024
