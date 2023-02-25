#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

#set -x
#echo "Enter cache device:"
#read cache
cache=cas1-1

#echo "Enter frontend device:"
#read frontend
frontend=$1

#echo "Enter backend device:"
#read backend
backend=$2

FILES="./jobfiles/"
for cleaning in alru 128 512
do
	for cbs in 4 8 16 32 #Cache block size
	do
		for nhit in always 2 4 8 16
		do

			for j in `ls $FILES | grep -v warmup`
			do
	
				numjobs=$(grep numjobs $j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
				name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
				if [ "$name" == "msxchg_3j" ]
				then
					lv_need="1"
				else
					lv_need="0"
				fi

				jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)
	
				mkdir ./outputs/$name
				cp -r ./Template/* ./outputs/$name/
				cp ./jobfiles/$jobfilename ./outputs/$name/
	
				echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	

				cd scripts
		#Some modifications to make things easier
				./Create_script.sh $cbs $nhit $cleaning $frontend $backend $lv_need
				echo "$(date) :$name: cache created" >> ../outputs/test_log.txt 
				
				cd ..	
	
				casadm -L
				echo "__________________________Performing Cache Warmup__________________________"
				if [ "$lv_need" == "1" ]
				then
					
					fio `echo ${FILES}$j | sed 's/\.fio/_warmup\.fio/g'`
				else
					
					fio --replay_redirect=/dev/$cache `echo ${FILES}$j | sed 's/\.fio/_warmup\.fio/g'`
				fi
				echo "__________________________Warmup Done!__________________________"
				
				cd ./outputs/$name
				echo "__________________________Performing Main Test__________________________"
				./OpenCAS-testing-script.sh $cache $frontend $backend $name $jobfilename $numjobs $lv_need
				echo "$(date) :$name: test completed" >> ../test_log.txt
				cd ../..
				cd scripts
				
				./Remove_script.sh $lv_need
				echo "$(date) :$name: cache deleted" >> ../outputs/test_log.txt
				cd ..
			done
			#Moving results to proper directory
			mv outputs/ results_cbs${cbs}_nhit${nhit}_clean${cleaning}/
			mkdir outputs

		done
	done
done
