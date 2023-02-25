#!/bin/sh

#set -x

#cleaning and removing cache
#dmsetup suspend dm-cache
#dmsetup suspend cache
#dmsetup suspend meta 
#dmsetup reload dm-cache --table '0 14998568960 cache /dev/mapper/meta /dev/mapper/cache /dev/sdb 64 0 cleaner 0' 
#dmsetup resume dm-cache 
#dmsetup wait dm-cache 
dmsetup remove dm-cache
dmsetup remove cache
dmsetup remove backend
dmsetup remove meta


rmmod brd
#handy
rm -f /dev/disk/by-id/ramdisk1


