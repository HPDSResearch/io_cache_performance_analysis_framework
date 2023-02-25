#!/bin/sh
#set -x
#MANUAL SETTING: Choose the backend block device properly
# the backend block device size is important [following the real trace type]
# VDI: At least 5TB backend
# TPCC: At least 400GB backend
# MS Exchange: At least 1.5TB backend
backend=/dev/disk/by-id/?
ramdisk_cache_device=/dev/disk/by-id/ramdisk1

cache_bs=$1
threshold=$2
cleaning_policy=$3

./ramdisk_create.sh
casadm -S -i 1 -d $ramdisk_cache_device --cache-line-size $cache_bs -c wb -f | tee -a ../outputs/test_log.txt
casadm -A -i 1 -d $backend | tee -a ../outputs/test_log.txt
if [[ $threshold -gt 1 ]]
then
#######Changing policy to nhit#############
	echo "_________________ CACHE CREATED WITH NHIT POLICY ____________________"
	casadm --set-param --name promotion -i 1 --policy nhit
	casadm --set-param --name promotion-nhit -i 1 --threshold $threshold
	casadm --set-param --name promotion-nhit --cache-id 1  --trigger 1
fi

if [[ $cleaning_policy -gt 1 ]]
then
	echo "_________________ CACHE CREATED WITH ACP CLEANING POLICY ____________________"
	casadm -X -n cleaning -i 1 -p acp
	casadm -X -n cleaning-acp -i 1 -w 10 -b $cleaning_policy
fi
#Check cache(OpenCAS)
casadm -L | tee -a ../outputs/test_log.txt
lsblk | tee -a ../outputs/test_log.txt
echo "Create cache done!" >> ../outputs/test_log.txt

if [ "$6" == "1" ]
then	
	
	dsk=/dev/"cas1-1"
	#/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}'`
	yes | pvcreate $dsk
	vgcreate vol_grp $dsk
	lvcreate -L 480G -n lv1 vol_grp
	lvcreate -L 480G -n lv2 vol_grp
	lvcreate -L 480G -n lv3 vol_grp
fi
