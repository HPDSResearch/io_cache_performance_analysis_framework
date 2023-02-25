#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

set -x

FILES="./jobfiles/*"

for j in $FILES; do
	
	
	name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
	jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)
	
	mkdir ./outputs/$name
	cp -r ./Template/* ./outputs/$name/
	cp ./jobfiles/$jobfilename ./outputs/$name/
	
	echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	

	cd scripts
	./ramdisk_create.sh
	echo "$(date) :$name: ramdisk created" >> ../outputs/test_log.txt 
	#read p
	cd ..	
	
	cd ./outputs/$name
	./Ramdisk-testing-script.sh $name $jobfilename
	echo "$(date) :$name: test completed" >> ../test_log.txt
	cd ../..

	cd scripts
	#read p
	./ramdisk_delete.sh 
	echo "$(date) :$name: ramdisk deleted" >> ../outputs/test_log.txt
	cd ..

done
