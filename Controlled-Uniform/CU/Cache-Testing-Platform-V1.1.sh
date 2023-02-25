#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023



######################################################
#####Define Color#####
Green='\033[1;32m' #Light Green
Blue='\033[0;34m' #Light Blue
Red='\033[0;31m' #Light Red
Cyan='\033[0;36m' #Light Cyan
NC='\033[0m' #No Color
######################################################
#####Get Input#####
#Get Cache
echo -e  "Select cache module that you want test:(${Green}OpenCAS, ${Blue}EnhanceIO, ${Red}DM-cache ${NC}==> ${Green}X${Blue}X${Red}X ${NC}(X= 0 or 1 )) " 
read CacheM

#Exchange & Define Cache Module Name
FChCacheM=${CacheM:0:1} 
SChCacheM=${CacheM:1:1}
TChCacheM=${CacheM:2:1}
if [ $FChCacheM == 1 ] 
then
OpenCAS=1
fi
if [ $SChCacheM == 1 ] 
then
EnhanceIO=1
fi
if [ $TChCacheM == 1 ] 
then
DM_cache=1
fi
 
 echo "Enter frontend device: /dev/?"
 read frontend
 echo "Enter backend device: /dev/?"
 read backend
 
#OpenCAS
if [ $OpenCAS == 1 ]
then
cd ./OpenCAS-Testing-Platform-V2 
./main_script.sh $frontend $backend 
cd ..
fi 

#DM-cache
if [ $DM_cache == 1 ]
then
cd ./DM-cache-Testing-Platform-V2  
./main_script.sh $frontend $backend
cd ..
fi 

#EnhanceIO
if [ $EnhanceIO == 1 ]
then
cd ./EnhanceIO-Testing-Platform-V2 
./main_script.sh $frontend $backend 
cd ..
fi 
