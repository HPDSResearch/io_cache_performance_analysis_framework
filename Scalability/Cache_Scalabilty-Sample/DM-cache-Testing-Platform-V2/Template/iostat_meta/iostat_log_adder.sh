#!/bin/bash

path=$(pwd)

for f in $path/$1-iostat*
do
        name=$(basename $f) 
        cat $f | awk '{print $1}' | tee MB_read_$name
        awk 'NF' MB_read_$name > MB_read_tmp_$name
        rm -f MB_read_$name
        mv MB_read_tmp_$name MB_read_$name
        cat $f | awk '{print $2}' | tee MB_wrtn_$name
        awk 'NF' MB_wrtn_$name > MB_wrtn_tmp_$name
        rm -f MB_wrtn_$name
        mv MB_wrtn_tmp_$name MB_wrtn_$name
done
