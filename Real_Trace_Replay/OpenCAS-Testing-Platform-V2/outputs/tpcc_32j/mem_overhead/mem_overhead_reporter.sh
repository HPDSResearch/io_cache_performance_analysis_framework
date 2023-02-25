#!/bin/sh

awk '/System Read Throughput/{print $5}' pcm_log >> pcm_r_log
awk '/System Write Throughput/{print $5}' pcm_log >> pcm_w_log
awk '/System Memory Throughput/{print $5}' pcm_log >> pcm_t_log
