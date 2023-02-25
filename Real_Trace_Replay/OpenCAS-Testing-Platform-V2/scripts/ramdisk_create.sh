#!/bin/sh


#MANUAL SETTING: Choose the proper RAM Disk size based on the trace
# You may refer to the paper for how to set the sizes, or simply uncomment the proper lines below.

modprobe brd rd_size=52428800 #For VDI
#20971520 #For TPCC
#75497472 #For MSXCHG
#62914560
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1
