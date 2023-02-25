#!/bin/bash

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

awk '/reads/{print $2}' ./$1 >> ./reads_log.txt
awk '/writes/{print $2}' ./$1 >> ./writes_log.txt
awk '! /dirty_write_hit_pct/ && /write_hit_pct/{print $2}' ./$1 > ./write_hit_rate_log.txt
awk '/read_hit_pct/{print $2}' ./$1 >> ./read_hit_rate_log.txt
awk '/rd_replace/{print $2}' ./$1 >> ./rd_replace_log.txt
awk '/wr_replace/{print $2}' ./$1 >> ./wr_replace_log.txt
awk '/cleanings/{print $2}' ./$1 >> ./cleanings_log.txt
awk '/nr_dirty/{print $2}' ./$1 >> ./nr_dirty_log.txt
awk '/uncached_reads/{print $2}' ./$1 >> ./uncached_reads_log.txt
awk '/uncached_writes/{print $2}' ./$1 >> ./uncached_writes_log.txt
awk '/disk_reads/{print $2}' ./$1 >> ./disk_reads_log.txt
awk '/disk_writes/{print $2}' ./$1 >> ./disk_writes_log.txt
awk '/ssd_writes/{print $2}' ./$1 >> ./ssd_writes_log.txt
awk '/ssd_reads/{print $2}' ./$1 >> ./ssd_reads_log.txt
