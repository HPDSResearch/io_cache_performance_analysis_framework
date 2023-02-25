#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

#set -x

#echo "Enter cache device:"
#read cache
cache=$2

#echo "Enter frontend device:"
#read frontend
frontend=$1

#echo "Enter backend device:"
#read backend
backend=$2

FILES="./jobfiles/"

for j in `ls $FILES | grep -v warmup`
do	
	
	numjobs=$(grep numjobs $j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
	name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
	jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)
	
	mkdir ./outputs/$name
	cp -r ./Template/* ./outputs/$name/
	cp ./jobfiles/$jobfilename ./outputs/$name/
	cp ./jobfiles/${name}_warmup.fio ./outputs/$name/
	
	echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	
	
	cd scripts
	./Create_script.sh -y
	echo "$(date) :$name: cache created" >> ../outputs/test_log.txt 
	
	cd ..	

	cd ./outputs/$name
	echo "__________________________Performing Test__________________________"
	./Enhanceio-testing-script.sh $cache $frontend $backend $name $jobfilename
	echo "$(date) :$name: test completed" >> ../test_log.txt
	cd ../..

	cd scripts
	eio_cli clean -c En_cache
	nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
	while [ $nr_dirty -gt 0 ]
	do
		sleep 20
		nr_dirty=$(cat /proc/enhanceio/En_cache/stats | grep nr_dirty | awk '{print $2}')
	done
	echo "$(date) :cache cleaned"
	
	./Remove_script.sh -y
	echo "$(date) :$name: cache deleted" >> ../outputs/test_log.txt
	cd ..

done
