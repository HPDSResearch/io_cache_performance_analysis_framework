#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023




set -x
#MANUAL SETTING: set the backend device id
# The values for access distributions in FIO tests of controlled uniform scripts
# are set for the case that the RAM Disk size is 1% of the backend device
# Therefore, for 10GB RAM Disk, the backend device must be at least 1TB capacity (or for 60GB RAM Disk, the backend must have at least 6TB capacity)
# Using smaller capacity block device as the backend would result in significantly different
# access locality, require changing the zoned distribution in fio job files for valid testing.
backend=/dev/disk/by-id/wwn-0x5002538c40af57c2
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
