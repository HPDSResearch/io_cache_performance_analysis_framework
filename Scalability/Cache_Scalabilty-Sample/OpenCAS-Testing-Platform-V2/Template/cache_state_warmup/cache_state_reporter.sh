#!/bin/bash


## Usage statistics ##
##1
#awk '/Occupancy/{print $4}' ./$1 >> Occupancy_Count_rate_log
#awk '/Occupancy/{print $6}' ./$1 >> Occupancy_Percentage_rate_log
#awk '/Free/{print $4}' ./$1 >> Free_Count_rate_log
#awk '/Free/{print $6}' ./$1 >> Free__Percentage_rate_log
awk '/║ Clean/{print $4}' ./$1 >> Clean_Count_rate_log
awk '/║ Clean/{print $6}' ./$1 >> Clean_Percentage_rate_log
awk '/║ Dirty/{print $4}' ./$1 >> Dirty_Count_rate_log
awk '/║ Dirty/{print $6}' ./$1 >> Dirty_Percentage_rate_log

## Request statistics ##
##1
#awk '/Read hits/{print $5}' ./$1 >> read_hit_Count_rate_log
awk '/Read hits/{print $7}' ./$1 >> read_hit_Percentage_rate_log
#awk '/Read partial misses/{print $6}' ./$1 >> Read_partial_misses_Count_rate_log
#awk '/Read partial misses/{print $8}' ./$1 >> Read_partial_misses_Percentage_rate_log
#awk '/Read full misses/{print $6}' ./$1 >> Read_full_misses_Count_rate_log
#awk '/Read full misses/{print $8}' ./$1 >> Read_full_misses_Percentage_rate_log
#awk '/Read total/{print $5}' ./$1 >> Read_total_Count_rate_log
#awk '/Read total/{print $7}' ./$1 >> Read_total_Percentage_rate_log
##2
#awk '/Write hits/{print $5}' ./$1 >> Write_hit_Count_rate_log
awk '/Write hits/{print $7}' ./$1 >> Write_hit_Percentage_rate_log
#awk '/Write partial misses/{print $6}' ./$1 >> Write_partial_misses_Count_rate_log
#awk '/Write partial misses/{print $8}' ./$1 >> Write_partial_misses_Percentage_rate_log
#awk '/Write full misses/{print $6}' ./$1 >> Write_full_misses_Count_rate_log
#awk '/Write full misses/{print $8}' ./$1 >> Write_full_misses_Percentage_rate_log
#awk '/Write total/{print $5}' ./$1 >> Write_total_Count_rate_log
#awk '/Write total/{print $7}' ./$1 >> Write_total_Percentage_rate_log
##3
awk '/Pass-Through reads/{print $5}' ./$1 >> Pass-Through_reads_Count_rate_log
#awk '/Pass-Through reads/{print $7}' ./$1 >> Pass-Through_reads_Percentage_rate_log
awk '/Pass-Through writes/{print $5}' ./$1 >> Pass-Through_writes_Count_rate_log
#awk '/Pass-Through writes/{print $7}' ./$1 >> Pass-Through_writes_Percentage_rate_log
#awk '/Serviced requests/{print $5}' ./$1 >> Serviced_requests_Count_rate_log
#awk '/Serviced requests/{print $7}' ./$1 >> Serviced_requests_Percentage_rate_log
##4
#awk '/Total requests/{print $6}' ./$1 >> Total_requests_Count_rate_log
#awk '/Total requests/{print $8}' ./$1 >> Total_requests_Percentage_rate_log

## Block statistics ## 
##1
awk '/Reads from core(s)/{print $6}' ./$1 >> Reads_from_core_Count_rate_log
#awk '/Reads from core(s)/{print $8}' ./$1 >> Reads_from_core_Percentage_rate_log
awk '/Writes to core(s)/{print $6}' ./$1 >> Writes_to_core_Count_rate_log
#awk '/Writes to core(s)/{print $8}' ./$1 >> Writes_to_core_Percentage_rate_log
#awk '/Total to/from core(s)/{print $6}' ./$1 >> Total_to/from_core_Count_rate_log
#awk '/Total to/from core(s)/{print $8}' ./$1 >> Total_to/from_core_Percentage_rate_log
##2
awk '/Reads from cache/{print $6}' ./$1 >> Reads_from_core_Count_rate_log
#awk '/Reads from cache/{print $8}' ./$1 >> Reads_from_core_Percentage_rate_log
awk '/Writes to cache/{print $6}' ./$1 >> Writes_to_cache_Count_rate_log
#awk '/Writes to cache/{print $8}' ./$1 >> Writes_to_cache_Percentage_rate_log
#awk '/Total to/from cache/{print $6}' ./$1 >> Total_to/from_cache_Count_rate_log
#awk '/Total to/from cache/{print $8}' ./$1 >> Total_to/from_cache_Percentage_rate_log
##3
#awk '/Reads from exported object(s)/{print $7}' ./$1 >> Reads_from_exported_object_Count_rate_log
#awk '/Reads from exported object(s)/{print $9}' ./$1 >> Reads_from_exported_object_Percentage_rate_log
#awk '/Writes to exported object(s)/{print $7}' ./$1 >> Writes_to_exported_object_Count_rate_log
#awk '/Writes to exported object(s)/{print $9}' ./$1 >> Writes_to_exported_object_Percentage_rate_log
#awk '/Total to/from exported object(s)/{print $7}' ./$1 >> Total_to/from_exported_object_Count_rate_log
#awk '/Total to/from exported object(s)/{print $9}' ./$1 >> Total_to/from_exported_object_Percentage_rate_log


## Error statistics ##
##1
#awk '/Cache read errors/{print $6}' ./$1 >> Cache_read_errors_Count_rate_log
#awk '/Cache read errors/{print $8}' ./$1 >> Cache_read_errors_Percentage_rate_log
#awk '/Cache write errors/{print $6}' ./$1 >> Cache_write_errors_Count_rate_log
#awk '/Cache write errors/{print $8}' ./$1 >> Cache_write_errors_Percentage_rate_log
#awk '/Cache total errors/{print $6}' ./$1 >> Cache_total_errors_Count_rate_log
#awk '/Cache total errors/{print $8}' ./$1 >> Cache_total_errors_Percentage_rate_log
##2
#awk '/Core read errors/{print $6}' ./$1 >> Core_read_errors_Count_rate_log
#awk '/Core read errors/{print $8}' ./$1 >> Core_read_errors_Percentage_rate_log
#awk '/Core write errors/{print $6}' ./$1 >> Core_write_errors_Count_rate_log
#awk '/Core write errors/{print $8}' ./$1 >> Core_write_errors_Percentage_rate_log
#awk '/Core total errors/{print $6}' ./$1 >> Core_total_errors_Count_rate_log
#awk '/Core total errors/{print $8}' ./$1 >> Core_total_errors_Percentage_rate_log
##3
#awk '/Total errors/{print $5}' ./$1 >> Total_errors_Count_rate_log
#awk '/Total errors/{print $7}' ./$1 >> Total_errors_Percentage_rate_log
