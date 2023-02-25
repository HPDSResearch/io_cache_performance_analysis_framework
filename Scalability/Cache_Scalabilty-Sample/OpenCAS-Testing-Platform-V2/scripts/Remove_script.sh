#!/bin/sh

#Remove cache(OpenCAS)
 casadm -L |tee -a ../outputs/test_log.txt
 casadm -T -i 1 -n 2>> ../outputs/test_log.txt
 casadm -L |tee -a ../outputs/test_log.txt
 lsblk >> ../outputs/test_log.txt

#Remove Ramdisk
rmmod brd
rm -f /dev/disk/by-id/ramdisk1

