#!/bin/bash

set -x

FILE="./jobfiles/*"
for cache in En DM CAS; do
    for file in $FILE ; do
        name=$(echo $file | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
        jobfilename=$(echo $file | rev | cut -d'/' -f 1 | rev)
        cd ./outputs/
        mkdir ${cache}_$name
        cp ../jobfiles/$jobfilename ./${cache}_$name
        cd ./${cache}_$name
	
        case $cache in
            CAS)
		bash ../../scripts/ramdisk_create.sh
                bash ../../scripts/CAS_Create_script.sh
		
                fio ../../seq_write_60g.fio --filename=/dev/cas1-1
                nr_dirty=$(casadm -P -i 1 | awk '/║ Dirty/{print $4}')
                while [ $nr_dirty -gt 0 ]
                do
                    sleep 20
                    nr_dirty=$(casadm -P -i 1 | awk '/║ Dirty/{print $4}')
                done
		
                perf record -a -g fio --filename=/dev/cas1-1 $jobfilename 
                perf report >> pert_out.txt
                bash ../../scripts/CAS_Remove_script.sh
		bash ../../scripts/ramdisk_delete.sh
                ;;

            En)
		bash ../../scripts/ramdisk_create.sh
                bash ../../scripts/En_Create_script.sh
		
                #MANUAL SETTING
                fio ../../seq_write_60g.fio --filename=/dev/?
		eio_cli clean -c En_cache
                nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
                while [ $nr_dirty -gt 0 ]
                do
                        sleep 20
                        nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
                done
		
                #MANUAL SETTING
                perf record -a -g fio --filename=/dev/? $jobfilename 
                perf report >> perf_out.txt
                bash ../../scripts/En_Remove_script.sh
		bash ../../scripts/ramdisk_delete.sh
                ;;

            DM)
		bash ../../scripts/ramdisk_create.sh
                bash ../../scripts/DM_Create_script.sh
		
                fio ../../seq_write_60g.fio --filename=/dev/mapper/dm-cache
                nr_dirty=$(dmsetup status | grep dm-cache | awk '{print $15}')
                while [ $nr_dirty -gt 0 ]
                do
                    sleep 20
                    nr_dirty=$(dmsetup status | grep dm-cache | awk '{print $15}')
                done
		
                perf record -a -g fio --filename=/dev/mapper/dm-cache $jobfilename 
                perf report >> perf_out.txt
                bash ../../scripts/DM_Remove_script.sh
		bash ../../scripts/ramdisk_delete.sh
                ;;

            *)
                echo "ERROR"
                ;;
        esac
        cd ../..
    done
done
