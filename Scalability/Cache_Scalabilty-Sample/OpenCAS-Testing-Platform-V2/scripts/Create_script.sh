#!/bin/sh

#Create ramdisk
modprobe brd rd_size=10485760
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1


#Create cache(OpenCAS)
 casadm -S -d /dev/disk/by-id/ramdisk1 -x 4 -c wb -f | tee -a ../outputs/test_log.txt
#handy
 casadm -A -i 1 -d /dev/disk/by-id/? | tee -a ../outputs/test_log.txt
 #casadm -X -n cleaning-alru -i 1 -w 3600
 #casadm -X -n cleaning -i 1 -p acp
 #casadm -X -n seq-cutoff -i 1 -j 1 -p always -t 64
 #Check cache(OpenCAS)
 casadm -L | tee -a ../outputs/test_log.txt
 lsblk | tee -a ../outputs/test_log.txt
 echo "Create cache done!" >> ../outputs/test_log.txt
