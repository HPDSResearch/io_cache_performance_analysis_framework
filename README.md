# General Description: 
This repository  consists of the source codes of the "I/O cache test & analysis framework" proposed in the paper "Re-architecting I/O Caches for Emerging Fast Storage Devices", appearing in ASPLOS'23.

# Hardware Dependencies:
Using the same system hardware as we specified in the paper would result in similar output to what we showed. However, using any other server configuration with minimal hardware requirements makes it still possible to run our scripts, but would naturally lead to different absolute performance, and system resource utilization numbers. 

## Recommended Configuration
 A storage server with dual-socket Intel Xeon E5-2620 v4 8-core CPUs (total 32 logical cores), at least 100GB of DRAM, 9x Samsung SM863a 1.9TB SSDs setup as RAID-5(8+1) using MegaRAID 9361. We set up a 6TB partition from this array, and use it as back-end storage.

## Minimal configuration:
A server with at least an 8-core CPU (total 16 logical cores), one server-grade SSD as the backend (in addition to the OS disk), and 32GB DRAM, from which 10GB are usable as the I/O cache device. Note that this configuration leads to different absolute performance numbers compared to our paper results, and thus is only suitable to check the ability to run our (sample) scripts. 


# Software Dependencies:
+ FIO 3.8
+ OpenCAS 21.3
+ EnhanceIO
+ DM-Cache

Running the experiments require the benchmarking tool FIO (version 3.8), CentOS 7 with kernel updated to 5.4.52, OpenCAS version 21.3, Lanconnected branch of EnhanceIO, and DM-Cache integrated in CentOS 7.
You need to ensure that both python version 2.7.5 (for EnhanceIO), and python version 3.6.8 (for OpenCAS), in addition to libaio (for FIO) are installed in their system.

# How to Run
After installing the prerequisites, the user is required to configure selected inputs exaplained in this section, and then run the top-level script for the desired I/O cache module, and the testing scenario.

For simplicity, we have divided the scripts into three groups (and directories): scalability, controlled uniform, and real traces. For all the scripts, if modifying a script to set a parameter value is required, we have added the comment "MANUAL SETTING" in that script.

Note that we have also provided sample scripts for most categories. These samples require smaller hardware requirements (i.e., 10GB RAM Disk instead of 60GB), and 1TB backend (instead of 6TB). The main goal of such samples is to enable basic functional verification faster and easier without requiring the complete recommended hardware.

The summarized explanation of each category and how to run them is found below.

## Scalability

This is the group of tests that examine the internal parallelism of I/O caches. These tests create an environment with 100% read hits, in which all requests are served from the cache device and not the backend.

* Step 1: Set the backend device path in "scripts/Create_scripts.sh". For OpenCAS, device-by-id and for EnhanceIO, the device name (e.g., sdX) is required. 

* Step 2: Run the *top_level_script.sh.* Select the desired cache module, and provide "ram1" as front-end ( or cache device), and "sdX" as the backend device. 

* Note that to run raw RAMDisk scalability tests, no code configuration is required. The user should only run "main_script.sh".

## Controlled Uniform

This group is for examining the cache miss handling mechanism. These tests create access patterns that result in the desired read cache hit-rates. The core idea of how to create specific hit-rates is using zoned distribution parameter of FIO. By modifying the flushing mechanism of the cache, flushing efficiency is also measured through these tests.

The steps to run these scripts are exactly same as the scalability tests.

## Real Traces

This group of tests measure the overall cache behavior under real applications. These scripts are generally usable with any real trace that is formatted in FIO-replayable format, but we specifically run Microsoft Exchange, Fujitsu VDI, and Oltpbench TPCC.

* Step 1: Download the real trace files and after decompressing, place them in /root/ path without changing the name. If the user wants to place the real trace input in another path, *read_iolog* value in fio job files must be set to the new path.

* Step 2: Set the backend device path in *scripts/Create_scripts.sh* (for OpenCAS and EnhanceIO only).

* Step 3: Select the proper cache size for each real trace. Set the RAMDisk size in *scripts/ramdisk_create.sh*

* Step 4: Copy the FIO job file of the desired trace from "jobfileRepo" to "jobfiles" directory. (as an example, we have placed Oltpbench TPCC job file in the "jobfiles" directory). Our framework runs the trace whose job file is in "jobfiles" directory.

* Step 5: To run Microsoft Exchange traces, uncomment five highlighted lines in *scripts/Create_scripts.sh* to create the required volume group and LUNs (for EnhanceIO only). 

* Step 6: To run Microsoft Exchange traces, refer to the file *Template/DM-testing-script.sh* for DM-Cache, and *main_script.sh* with *Template/Enhanceio-testing-script.sh* for EnhanceIO to enable proper fio replay command. (for OpenCAS, no specific modification is required to handle this trace)

* Step 7: Run the *main_script.sh* with first argument as /dev/ram1 and second argument as /dev/sdX.


# LICENSING and USAGE
Please refer to the LICENSE file. A very brief description is as follows:

This piece of software can be used free of charge for both academic and commercial purposes.

If you use this code, please cite the following paper:

M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi, "Re-architecting I/O Caches for Emerging Fast Storage Devices", ASPLOS 2023

Link on ACM Library: https://dl.acm.org/doi/10.1145/3582016.3582041
