#!/bin/bash

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023


path=$(pwd)

#echo "Enter output name pattern of logs:"
#read oname

for f in $path/$1-iostat*
do
        name=$(basename $f) 
        cat $f | awk '{print $1}' | tee MB_read_$name
        awk 'NF' MB_read_$name > MB_read_tmp_$name
        rm -f MB_read_$name
        mv MB_read_tmp_$name MB_read_$name
        cat $f | awk '{print $2}' | tee MB_wrtn_$name
        awk 'NF' MB_wrtn_$name > MB_wrtn_tmp_$name
        rm -f MB_wrtn_$name
        mv MB_wrtn_tmp_$name MB_wrtn_$name
done
