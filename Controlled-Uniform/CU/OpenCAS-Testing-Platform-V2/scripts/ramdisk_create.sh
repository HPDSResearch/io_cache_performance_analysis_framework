#!/bin/bash

modprobe brd rd_size=62914560
ln -s /dev/ram1 /dev/disk/by-id/ramdisk1
