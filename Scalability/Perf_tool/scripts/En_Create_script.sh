#!/bin/sh
#set -x


frontend='/dev/ram1'

#MANUAL SETTING. Replace ? with proper backend device. For example, sdb
backend=/dev/?

eio_cli create -d $backend -s $frontend  -p lru -m wb -b 4096 -c En_cache
