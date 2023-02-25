#!/bin/bash

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023


pwd=$(pwd)
for f in $pwd/$1*
do
        cut $f -d ',' -f 2 > ${f}_temp
done
paste $pwd/$1*_temp | awk '{TR=0; for(I=1; I<=NF; I++) TR+=$I; print TR}' > $pwd/fio_iops_log.txt