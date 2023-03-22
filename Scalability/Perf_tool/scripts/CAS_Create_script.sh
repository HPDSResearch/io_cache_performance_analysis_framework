#!/bin/sh
#set -x

#MANUAL SETTING: Replace ? with right value (device by-id of the desired backend block device)

backend=/dev/disk/by-id/?
ramdisk_cache_device=/dev/disk/by-id/ramdisk1

sleep 5
casadm -S -i 1 -d $ramdisk_cache_device -c wb -f 
casadm -A -i 1 -d $backend
