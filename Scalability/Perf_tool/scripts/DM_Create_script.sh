#!/bin/bash


#MANUAL SETTING Replace ? with proper backend device. For example, sdb
cache_device=ram1
backend_device=? 
blocksize=32
writing_mode=wb


bs=$(($blocksize))
BS=$(expr $bs \* 1024 )
bs_sector=$(expr $BS / 512 )
cache_size=$(blockdev --getsize64 /dev/$cache_device)
num_of_blks=$(expr $cache_size / $BS )
temp=$(expr 16 \* $num_of_blks)
meta_size=$(expr 5242880 + $temp )
cache_size=$(expr $cache_size - $meta_size)
cache_size=$(expr $cache_size / 512 ) 
meta_sector_size=$( expr $meta_size / 512 )
backend_size=$(blockdev --getsz /dev/$backend_device)

case $writing_mode in

  wb)
    writemode="writeback"
    ;;

  wt)
    writemode="writethrough"
    ;;

  pt)
    writemode="passthrough"
    ;;

esac


echo -e "0 $meta_sector_size linear /dev/$cache_device 0" | dmsetup create meta

echo -e "0 $cache_size linear /dev/$cache_device $meta_sector_size" | dmsetup create cache

echo -e "0 $backend_size linear /dev/$backend_device 0" | dmsetup create backend


mkfs.ext4 /dev/mapper/meta
mkfs.ext4 /dev/mapper/backend
mkfs.ext4 /dev/mapper/cache
meta_sector_count=$(blockdev --getsz /dev/mapper/meta)
dd if=/dev/zero of=/dev/mapper/meta bs=512 count=$meta_sector_count
echo -e "0 $backend_size cache /dev/mapper/meta /dev/mapper/cache /dev/mapper/backend $bs_sector 1 $writemode default 0" | dmsetup create dm-cache
