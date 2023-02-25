#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023


if [ $2 == r -o $2 == rw ]
then
awk '{print $9}' $1 > read_hit.txt
awk '{print $10}' $1 > read_miss.txt
awk '{print ($9/($9+$10))}' $1 > read_hitratio.txt
fi
if [ $2 == w -o $2 == rw ]
then
awk '{print $11}' $1 > write_hit.txt
awk '{print $12}' $1 > write_miss.txt
awk '{print ($11/($11+$12))}' $1 > write_hitratio.txt
fi
awk '{print $15}' $1 > num_of_dirty.txt
awk '{print $14}' $1 > num_of_promotion.txt
awk '{print $13}' $1 > num_of_demotion.txt
total=$(awk 'NR==1 {print $8}' $1 | awk 'BEGIN { FS = "/" } ; { print $2 }')
echo $total > num_of_cache_blocks.txt
awk -v var="$total" '{print var-$15}' $1 > num_of_clean.txt
