#!/bin/bash


pwd=$(pwd)
for f in $pwd/$1*
do
        cut $f -d ',' -f 2 > ${f}_temp
done
paste $pwd/$1*_temp | awk '{TR=0; for(I=1; I<=NF; I++) TR+=$I; print TR}' > $pwd/fio_iops_log.csv
rm -f *_temp
