#!/bin/bash

# Developed as part of the artifact for a research project at HPDS Research and DSN lab of Sharif University of Technology.
# If you use this code, Please cite the following paper:
#Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
#Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
# Venue: ASPLOS 2023



## Usage statistics ##
##1
#awk '/Occupancy/{print $4}' ./$1 >> Occupancy_Count_rate_log.csv
#awk '/Occupancy/{print $6}' ./$1 >> Occupancy_Percentage_rate_log.csv
#awk '/Free/{print $4}' ./$1 >> Free_Count_rate_log.csv
#awk '/Free/{print $6}' ./$1 >> Free__Percentage_rate_log.csv
awk '/║ Clean/{print $4}' ./$1 >> Clean_Count_rate_log.csv
awk '/║ Clean/{print $6}' ./$1 >> Clean_Percentage_rate_log.csv
awk '/║ Dirty/{print $4}' ./$1 >> Dirty_Count_rate_log.csv
awk '/║ Dirty/{print $6}' ./$1 >> Dirty_Percentage_rate_log.csv

## Request statistics ##
##1
#awk '/Read hits/{print $5}' ./$1 >> read_hit_Count_rate_log.csv
awk '/Read hits/{print $7}' ./$1 >> read_hit_Percentage_rate_log.csv
#awk '/Read partial misses/{print $6}' ./$1 >> Read_partial_misses_Count_rate_log.csv
#awk '/Read partial misses/{print $8}' ./$1 >> Read_partial_misses_Percentage_rate_log.csv
#awk '/Read full misses/{print $6}' ./$1 >> Read_full_misses_Count_rate_log.csv
#awk '/Read full misses/{print $8}' ./$1 >> Read_full_misses_Percentage_rate_log.csv
#awk '/Read total/{print $5}' ./$1 >> Read_total_Count_rate_log.csv
#awk '/Read total/{print $7}' ./$1 >> Read_total_Percentage_rate_log.csv
##2
#awk '/Write hits/{print $5}' ./$1 >> Write_hit_Count_rate_log.csv
awk '/Write hits/{print $7}' ./$1 >> Write_hit_Percentage_rate_log.csv
#awk '/Write partial misses/{print $6}' ./$1 >> Write_partial_misses_Count_rate_log.csv
#awk '/Write partial misses/{print $8}' ./$1 >> Write_partial_misses_Percentage_rate_log.csv
#awk '/Write full misses/{print $6}' ./$1 >> Write_full_misses_Count_rate_log.csv
#awk '/Write full misses/{print $8}' ./$1 >> Write_full_misses_Percentage_rate_log.csv
#awk '/Write total/{print $5}' ./$1 >> Write_total_Count_rate_log.csv
#awk '/Write total/{print $7}' ./$1 >> Write_total_Percentage_rate_log.csv
##3
awk '/Pass-Through reads/{print $5}' ./$1 >> Pass-Through_reads_Count_rate_log.csv
#awk '/Pass-Through reads/{print $7}' ./$1 >> Pass-Through_reads_Percentage_rate_log.csv
awk '/Pass-Through writes/{print $5}' ./$1 >> Pass-Through_writes_Count_rate_log.csv
#awk '/Pass-Through writes/{print $7}' ./$1 >> Pass-Through_writes_Percentage_rate_log.csv
#awk '/Serviced requests/{print $5}' ./$1 >> Serviced_requests_Count_rate_log.csv
#awk '/Serviced requests/{print $7}' ./$1 >> Serviced_requests_Percentage_rate_log.csv
##4
#awk '/Total requests/{print $6}' ./$1 >> Total_requests_Count_rate_log.csv
#awk '/Total requests/{print $8}' ./$1 >> Total_requests_Percentage_rate_log.csv

## Block statistics ## 
##1
awk '/Reads from core(s)/{print $6}' ./$1 >> Reads_from_core_Count_rate_log.csv
#awk '/Reads from core(s)/{print $8}' ./$1 >> Reads_from_core_Percentage_rate_log.csv
awk '/Writes to core(s)/{print $6}' ./$1 >> Writes_to_core_Count_rate_log.csv
#awk '/Writes to core(s)/{print $8}' ./$1 >> Writes_to_core_Percentage_rate_log.csv
#awk '/Total to/from core(s)/{print $6}' ./$1 >> Total_to/from_core_Count_rate_log.csv
#awk '/Total to/from core(s)/{print $8}' ./$1 >> Total_to/from_core_Percentage_rate_log.csv
##2
awk '/Reads from cache/{print $6}' ./$1 >> Reads_from_core_Count_rate_log.csv
#awk '/Reads from cache/{print $8}' ./$1 >> Reads_from_core_Percentage_rate_log.csv
awk '/Writes to cache/{print $6}' ./$1 >> Writes_to_cache_Count_rate_log.csv
#awk '/Writes to cache/{print $8}' ./$1 >> Writes_to_cache_Percentage_rate_log.csv
#awk '/Total to/from cache/{print $6}' ./$1 >> Total_to/from_cache_Count_rate_log.csv
#awk '/Total to/from cache/{print $8}' ./$1 >> Total_to/from_cache_Percentage_rate_log.csv
##3
#awk '/Reads from exported object(s)/{print $7}' ./$1 >> Reads_from_exported_object_Count_rate_log.csv
#awk '/Reads from exported object(s)/{print $9}' ./$1 >> Reads_from_exported_object_Percentage_rate_log.csv
#awk '/Writes to exported object(s)/{print $7}' ./$1 >> Writes_to_exported_object_Count_rate_log.csv
#awk '/Writes to exported object(s)/{print $9}' ./$1 >> Writes_to_exported_object_Percentage_rate_log.csv
#awk '/Total to/from exported object(s)/{print $7}' ./$1 >> Total_to/from_exported_object_Count_rate_log.csv
#awk '/Total to/from exported object(s)/{print $9}' ./$1 >> Total_to/from_exported_object_Percentage_rate_log.csv


## Error statistics ##
##1
#awk '/Cache read errors/{print $6}' ./$1 >> Cache_read_errors_Count_rate_log.csv
#awk '/Cache read errors/{print $8}' ./$1 >> Cache_read_errors_Percentage_rate_log.csv
#awk '/Cache write errors/{print $6}' ./$1 >> Cache_write_errors_Count_rate_log.csv
#awk '/Cache write errors/{print $8}' ./$1 >> Cache_write_errors_Percentage_rate_log.csv
#awk '/Cache total errors/{print $6}' ./$1 >> Cache_total_errors_Count_rate_log.csv
#awk '/Cache total errors/{print $8}' ./$1 >> Cache_total_errors_Percentage_rate_log.csv
##2
#awk '/Core read errors/{print $6}' ./$1 >> Core_read_errors_Count_rate_log.csv
#awk '/Core read errors/{print $8}' ./$1 >> Core_read_errors_Percentage_rate_log.csv
#awk '/Core write errors/{print $6}' ./$1 >> Core_write_errors_Count_rate_log.csv
#awk '/Core write errors/{print $8}' ./$1 >> Core_write_errors_Percentage_rate_log.csv
#awk '/Core total errors/{print $6}' ./$1 >> Core_total_errors_Count_rate_log.csv
#awk '/Core total errors/{print $8}' ./$1 >> Core_total_errors_Percentage_rate_log.csv
##3
#awk '/Total errors/{print $5}' ./$1 >> Total_errors_Count_rate_log.csv
#awk '/Total errors/{print $7}' ./$1 >> Total_errors_Percentage_rate_log.csv
