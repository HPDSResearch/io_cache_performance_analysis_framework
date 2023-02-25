#!/bin/bash
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

set -x

FILE=$1
output_name=$2

echo ",avg_iops,avg_lat(ns),tail_9999(ns),tail_9995(ns),tail_9990(ns),tail_99(ns)" >> $output_name-fio-parsed.csv

write_line_number=$(grep -n "write:" $FILE | awk -F':' '{print $1}')

if [ -z "$write_line_number" ]
then	
	write_line_number=$(wc -l $FILE | awk '{print $1}')
	let write_line_number+1
fi

read_part=$(awk -v var=$write_line_number 'NR<var {print}' $FILE )
write_part=$(awk -v var=$write_line_number 'NR>=var {print}' $FILE )

Parse () {

	avg_iops=$(echo "$1" | grep IOPS | awk '{print $2}' | tr -d , | awk -F'=' '{print $2}')
	unit=$(echo "${avg_iops:0-1}")

	if [ "$unit" == "k" ]
	then
		avg_iops=$(echo $avg_iops | awk '{print $1*1000}')
	fi
	unit=$(echo "$1" | grep -A 2 -w "slat" | tail -1 | tr , " " | tr : " " | tr = " " | awk '{print $2}')
	avg_lat=$(echo "$1" | grep -A 2 -w "slat" | tail -1 | tr , " " | tr : " " | tr = " " | awk '{print $8}')
	
	if [ "$unit" == "(usec)" ]
	then
		avg_lat=$(echo $avg_lat | awk '{print $1*1000}')
	fi
	line_num1=$(echo "$1" | grep -n -w -e "lat percentiles" | awk -F':' '{print $1}')
	line_num2=$(echo "$1" | grep -n -w -e "bw (" | awk -F':' '{print $1}')
	
	lat_percentiles=$(echo "$1" | awk -v var1=$line_num1 -v var2=$line_num2 'NR<var2 && NR>=var1 {print}')
	unit=$(echo "$lat_percentiles" | head -1 | tr : " " | awk '{print $3}')
	tail_latencies=$(echo "$lat_percentiles" | tr "|" " " | tr = " " | tr , " " | tr [ " " | tr ] " " | awk '{for(i=1; i<=NF; i++) {if($i=="99.00th" || $i=="99.90th" || $i=="99.99th" || $i=="99.95th") print $i,$(i+1)}}' | sort -rk1)
	if [ "$unit" == "(usec)" ]
	then
		tail_latencies=$(echo "$tail_latencies" | awk '{printf "%s\t%s\n", $1,$2*1000}')
	fi
	echo -n "$avg_iops," >> $output_name-fio-parsed.csv
	echo -n "$avg_lat," >> $output_name-fio-parsed.csv
	for i in $(echo "$tail_latencies" | awk '{print $2}')
	do
		echo -n "$i," >> $output_name-fio-parsed.csv
	done
	
}

echo -n "read," >> $output_name-fio-parsed.csv
Parse "$read_part"
echo -ne "\n" >> $output_name-fio-parsed.csv
echo -n "write," >> $output_name-fio-parsed.csv
Parse "$write_part"


