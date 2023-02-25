#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023


echo "----------------------performing warmup test----------------"
fio --filename=/dev/ram1 seq_write_60G.fio

sleep 5

echo "----------------------performing main test------------------"

						
fio --filename=/dev/ram1 --write_iops_log=fio_log $2  1>& $1-fio_output.txt 



#mv warmup_fio_log_iops.* warmup_fio_iops/
mv fio_log* fio_iops/


cd ./fio_iops
./fio_iops_adder.sh fio_log

#cd ../warmup_fio_iops
#./fio_iops_adder.sh warmup_fio_log

cd ..
./fio_output_parser.sh $1-fio_output.txt $1 

cd ..
