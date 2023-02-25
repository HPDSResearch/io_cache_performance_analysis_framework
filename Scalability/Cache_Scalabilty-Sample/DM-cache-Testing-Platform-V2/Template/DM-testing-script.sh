#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

# $1 --> cache 
# $2 --> frontend 
# $3 --> meta
# $4 --> backend 
# $5 --> name 
# $6 --> mode 
# $7 --> jobfilename

echo "----------------------performing warmup test----------------"
fio --filename=/dev/$1 seq_write_60G.fio &
pid1=$!  


while kill -0 $pid1 2> /dev/null; do
        dmsetup status | grep dm-cache | tee -a $output-cache-state-warmup.txt         
        sleep 10
done

echo "----------------------performing main test------------------"

iostat -m 10 -d /dev/$4 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $5-iostat-backend.txt &

iostat -m 10 -d /dev/$3 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $5-iostat-meta.txt &			

iostat -m 10 -d /dev/$2 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $5-iostat-frontend.txt &

#pcm-memory.x 1 > pcm_log &
			
fio --filename=/dev/$1 --write_iops_log=fio_log $7  1>& $5-fio_output.txt &
pid2=$!	


while kill -0 $pid2 2> /dev/null; do
		sleep 10
		dmsetup status | grep dm-cache | tee -a $5-cache-state.txt

done

killall -9 iostat
#killall -9 pcm-memory.x

#mv warmup_fio_log_iops.* warmup_fio_iops/
mv fio_log_iops.* fio_iops/
#mv pcm_log mem_overhead/
mv $5-cache-state.txt cache_state/
#mv $5-cache-state-warmup.txt cache_state_warmup/
mv $5-iostat-frontend.txt iostat_frontend/
mv $5-iostat-backend.txt iostat_backend/
mv $5-iostat-meta.txt iostat_meta/

cd cache_state
./cache_state_reporter.sh $5-cache-state.txt $6

#cd ../cache_state_warmup
#./cache_state_reporter.sh $5-cache-state-warmup.txt $6

#cd ../mem_overhead
#./mem_overhead_reporter.sh

cd ../iostat_frontend
./iostat_log_adder.sh $5

cd ../iostat_meta
./iostat_log_adder.sh $5

cd ../iostat_backend
./iostat_log_adder.sh $5

cd ../fio_iops
./fio_iops_adder.sh fio_log 

#cd ../warmup_fio_iops
#./fio_iops_adder.sh warmup_fio_log

cd ..
./fio_output_parser.sh $5-fio_output.txt $5-fio-parsed.csv

cd ..
