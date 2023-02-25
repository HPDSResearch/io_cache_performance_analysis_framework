#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023


#echo "----------------------performing warmup test----------------"
#fio --filename=/dev/$1 --write_iops_log=warmup_fio_log seq_write_100G.fio &
#pid1=$!  


#while kill -0 $pid1 2> /dev/null; do
#        cat /proc/enhanceio/En_cache/stats | tee -a $4-cache-state-warmup.txt         
#        sleep 10
#done


#nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
#        while [ $nr_dirty -gt 0 ]
#        do
#                sleep 20
#                nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
#        done

echo "----------------------performing main test------------------"

iostat -m 10 -d /dev/$3 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-backend.txt &
						
iostat -m 10 -d /dev/$2 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-frontend.txt &

#pcm-memory.x 1 > pcm_log &
			
fio --write_iops_log=fio_log --replay_redirect=/dev/$1 $5 1>& $4-fio_output.txt &
#fio --write_iops_log=fio_log $5 1>& $4-fio_output.txt & #For MSXCHG
pid2=$!	


while kill -0 $pid2 2> /dev/null; do
    	sleep 10
	cat /proc/enhanceio/En_cache/stats | tee -a $4-cache-state.txt  	
done

killall -9 iostat
#killall -9 pcm-memory.x
#mv warmup_fio_log_iops.* warmup_fio_iops/
mv fio_log_iops.* fio_iops/
#mv pcm_log mem_overhead/
mv $4-cache-state.txt cache_state/
#mv $4-cache-state-warmup.txt cache_state_warmup/
mv $4-iostat-frontend.txt iostat_frontend/
mv $4-iostat-backend.txt iostat_backend/

cd cache_state 
./cache_state_reporter.sh $4-cache-state.txt 

#cd ../cache_state_warmup
#./cache_state_reporter.sh $4-cache-state-warmup.txt 

#cd ../mem_overhead
#./mem_overhead_reporter.sh

cd ../iostat_frontend
./iostat_log_adder.sh $4

cd ../iostat_backend
./iostat_log_adder.sh $4

cd ../fio_iops
./fio_iops_adder.sh fio_log 

#cd ../warmup_fio_iops
#./fio_iops_adder.sh warmup_fio_log

cd ../..
