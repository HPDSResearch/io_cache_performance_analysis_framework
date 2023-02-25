#!/bin/sh
# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023

awk '/System Read Throughput/{print $5}' pcm_log >> pcm_r_log
awk '/System Write Throughput/{print $5}' pcm_log >> pcm_w_log
awk '/System Memory Throughput/{print $5}' pcm_log >> pcm_t_log
