#!/bin/bash

modprobe brd rd_size=10485760
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1
