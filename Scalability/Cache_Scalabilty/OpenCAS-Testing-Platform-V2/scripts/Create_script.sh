#!/bin/sh

#Create ramdisk
modprobe brd rd_size=62914560
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1


#Create cache(OpenCAS)
 casadm -S -d /dev/disk/by-id/ramdisk1 -x 4 -c wb -f | tee -a ../outputs/test_log.txt
#MANUAL SETTING: Replace ? with right value (device by-id of the desired backend block device)
 casadm -A -i 1 -d /dev/disk/by-id/? | tee -a ../outputs/test_log.txt
 
 #Check cache(OpenCAS)
 casadm -L | tee -a ../outputs/test_log.txt
 lsblk | tee -a ../outputs/test_log.txt
 echo "Create cache done!" >> ../outputs/test_log.txt
