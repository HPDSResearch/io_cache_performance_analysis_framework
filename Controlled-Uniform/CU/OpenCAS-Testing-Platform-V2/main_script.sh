#!/bin/bash
set -x
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
for cleaning in alru 128 256 512
do
	for cbs in 4 8 16 32 #Cache block size
	do
		for nhit in always 2 4 8 16
		do

			for j in `ls $FILES | grep -v warmup`
			do
				#numjobs=$(grep numjobs $j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
				name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
				jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)

					

				mkdir ./outputs/$name
				cp -r ./Template/* ./outputs/$name/
				cp ./jobfiles/$jobfilename ./outputs/$name/
				cp ./jobfiles/${name}_warmup.fio ./outputs/$name/
	
				echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	

				cd scripts
				#Some modifications to make things easier
				./Create_script.sh $cbs $nhit $cleaning $frontend $backend
				echo "$(date) :$name: cache created" >> ../outputs/test_log.txt 
				#
				cd ..	
	
				casadm -L
				
				

				cd ./outputs/$name
				echo "__________________________Performing Test__________________________"
				./OpenCAS-testing-script.sh $cache $frontend $backend $name $jobfilename $numjobs
				echo "$(date) :$name: test completed" >> ../test_log.txt
				cd ../..
				cd scripts
				#
				./Remove_script.sh
				echo "$(date) :$name: cache deleted" >> ../outputs/test_log.txt
				cd ..
				

				#Moving results to proper directory
				mv outputs/ results_cbs${cbs}_nhit${nhit}_clean${cleaning}/
				mkdir outputs
			done

		done
	done
done
