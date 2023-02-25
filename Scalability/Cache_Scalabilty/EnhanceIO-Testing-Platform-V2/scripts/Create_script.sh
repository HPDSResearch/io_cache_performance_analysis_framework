#!/bin/sh

#set -x

#Creating Ramdisk
modprobe brd rd_size=62914560
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1

#Creating Enhanceio
#handy
eio_cli create -d /dev/? -s /dev/ram1 -p lru -m wb -b 4096 -c En_cache
