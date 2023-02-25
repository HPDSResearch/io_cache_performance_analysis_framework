#!/bin/sh

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

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
