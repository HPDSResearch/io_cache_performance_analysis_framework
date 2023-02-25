#!/bin/sh

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

set -x

if [ ! -z "$(ls | grep $(echo $5 | sed 's/\.fio/_warmup\.fio/g'))" ]
then

    
    echo "__________________________Performing Cache Warmup__________________________"

    fio --filename=/dev/$1 --write_iops_log=warmup_fio_log `echo $5 | sed 's/\.fio/_warmup\.fio/g'` &
    pid1=$!

    while kill -0 $pid1 2> /dev/null; do
        casadm -P -i 1 | tee -a $4-cache-state-warmup.txt
        sleep 10
    done

    nr_dirty=$(casadm -P -i 1 | awk '/║ Dirty/{print $4}')
    while [ $nr_dirty -gt 0 ]
    do
        sleep 20
        nr_dirty=$(casadm -P -i 1 | awk '/║ Dirty/{print $4}')
    done
    echo "__________________________Warmup Done!__________________________"
fi



echo "----------------------performing main test------------------"

iostat -m 10 -d /dev/$3 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-backend.txt &
						
iostat -m 10 -d /dev/$2 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-frontend.txt &

#pcm-memory.x 1 > pcm_log &
	
fio --write_iops_log=fio_log --filename=/dev/$1 $5 --log_avg_msec=10000 1>& $4-fio_output.txt &
pid2=$!


while kill -0 $pid2 2> /dev/null; do
    	sleep 10 
        casadm -P -i 1 | tee -a $4-cache-state.txt  	
done

killall -9 iostat
#killall -9 pcm-memory.x

#mv warmup_fio_log* warmup_fio_iops/
mv fio_log* fio_iops/
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

cd ..
./fio_output_parser.sh $4-fio_output.txt $4


cd ..
