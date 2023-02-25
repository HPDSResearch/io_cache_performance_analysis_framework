#!/bin/sh
set -x

#Remove cache(OpenCAS)
dsk=/dev/"cas1-1"
#raid=/dev/`lsblk | grep 14T | awk -F ' ' '{print $1}' | head -n 1`

casadm -L |tee -a ../outputs/test_log.txt
casadm -T -i 1 -n 2>> ../outputs/test_log.txt
casadm -L |tee -a ../outputs/test_log.txt
lsblk >> ../outputs/test_log.txt
#sync
#partprobe
#wipefs $raid
#dd if=/dev/zero of=$raid bs=1M count=1024
