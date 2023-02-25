#!/bin/bash

#echo "Enter cache device:"
#read cache
cache=cas1-1

#echo "Enter frontend device:"
#read frontend
frontend=$1

#echo "Enter backend device:"
#read backend
backend=$2

FILES="./jobfiles/*"

for j in $FILES; do
	
	
	numjobs=$(grep numjobs $j | awk 'BEGIN { FS = "=" } ; { print $2 } ')
	name=$(echo $j | rev | cut -d'/' -f 1 | rev | cut -d'.' -f 1)
	jobfilename=$(echo $j | rev | cut -d'/' -f 1 | rev)
	
	mkdir ./outputs/$name
	cp -r ./Template/* ./outputs/$name/
	cp ./jobfiles/$jobfilename ./outputs/$name/
	
	echo "$(date) :$name test directory created-Template copied-jobfile copied" >> ./outputs/test_log.txt	

	cd scripts
	./Create_script.sh
	echo "$(date) :$name: cache created" >> ../outputs/test_log.txt 
	#read p
	cd ..	
	
	cd ./outputs/$name
	./OpenCAS-testing-script.sh $cache $frontend $backend $name $jobfilename $numjobs
	echo "$(date) :$name: test completed" >> ../test_log.txt
	cd ../..

	cd scripts
	#read p
	./Remove_script.sh 
	echo "$(date) :$name: cache deleted" >> ../outputs/test_log.txt
	cd ..

done
