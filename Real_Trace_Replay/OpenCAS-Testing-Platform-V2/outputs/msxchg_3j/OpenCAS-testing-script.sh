#!/bin/sh

set -x

echo "----------------------performing main test------------------"

iostat -m 10 -d /dev/$3 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-backend.txt &
						
iostat -m 10 -d /dev/$2 |awk 'NR>2 {print $3,$4}'|grep -v -e "MB_read/s" -e "MB_wrtn/s" | tee -a $4-iostat-frontend.txt &

#pcm-memory.x 1 > pcm_log &
if [ "$7" == "1" ]
then	
    fio --write_iops_log=fio_log $5 --log_avg_msec=10000 1>& $4-fio_output.txt &
    pid2=$!
else 
    fio --replay_redirect=/dev/$1 --write_iops_log=fio_log --log_avg_msec=10000 $5 1>& $4-fio_output.txt &
    pid2=$!
fi

while kill -0 $pid2 2> /dev/null; do
    	sleep 10 
        casadm -P -i 1 | tee -a $4-cache-state.txt  	
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

cd ..
./fio_output_parser.sh $4-fio_output.txt $4

cd ..

