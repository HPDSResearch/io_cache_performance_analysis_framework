#!/bin/sh

#set -x

#Removing Enhanceio
eio_cli delete -c En_cache

#Removing Ramdiks
rmmod brd
#handy
rm -f /dev/disk/by-id/ramdisk1
