#!/bin/sh

dmsetup remove dm-cache
dmsetup remove cache
dmsetup remove backend
dmsetup remove meta

