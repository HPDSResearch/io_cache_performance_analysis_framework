#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

#$1 frontend
#$2 backend

#set -x

#echo "Enter cache device:"
#read cache
cache=mapper/dm-cache

#echo "Enter frontend device:"
#read frontend
frontend=mapper/cache

#echo "Enter backend device:"
#read backend
backend=mapper/backend

#echo "Enter Metadata device:"
#read meta
meta=mapper/meta


FILES="./jobfiles/"

for j in `ls $FILES | grep -v warmup`
do
	
	readwrite=$(grep readwrite ${FILES}$j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
	
	if [ $readwrite == randread -o $readwrite == read ]
	then
		mode=r
	fi

	if [ $readwrite == randwrite -o $readwrite == write ]
	then
            mode=w
    fi

	if [ $readwrite == randrw -o $readwrite == rw ]
	then
            mode=rw
    fi
	#numjobs=$(grep numjobs ${FILES}$j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
	name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
	jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)
	
	

	mkdir ./outputs/$name
	cp -r ./Template/* ./outputs/$name/
	cp ./jobfiles/$jobfilename ./outputs/$name/
	cp ./jobfiles/${name}_warmup.fio ./outputs/$name/

	
	
	echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	

	cd scripts
	####################
	./ramdisk_create.sh 
	####################
	./Create_script.sh $1 $2 32 wb
	echo "$(date) :$name: cache created" >> ../outputs/test_log.txt 
	cd ..	
	####################
	
	cd ./outputs/$name
	./DM-testing-script.sh $cache $frontend $meta $backend $name $mode $jobfilename
	echo "$(date) :$name: test completed" >> ../test_log.txt
	cd ../..

	cd scripts
	./Remove_script.sh -y
	####################
	./ramdisk_delete.sh
	####################
	echo "$(date) :$name: cache deleted" >> ../outputs/test_log.txt
	cd ..

done
