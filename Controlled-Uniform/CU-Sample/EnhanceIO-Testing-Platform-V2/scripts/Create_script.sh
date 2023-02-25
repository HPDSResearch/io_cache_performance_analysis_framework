#!/bin/sh


./ramdisk_create.sh
frontend='/dev/ram1'
#MANUAL SETTING: Set the backend device
# The values for access distributions in FIO tests of controlled uniform scripts
# are set for the case that the RAM Disk size is 1% of the backend device
# Therefore, for 10GB RAM Disk, the backend device must be at least 1TB capacity (or for 60GB RAM Disk, the backend must have at least 6TB capacity)
# Using smaller capacity block device as the backend would result in significantly different
# access locality, require changing the zoned distribution in fio job files for valid testing.
backend='?'

eio_cli create -d $backend -s $frontend  -p lru -m wb -b 4096 -c En_cache

