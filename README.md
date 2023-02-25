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

# LICENSING and USAGE
Please refer to the LICENSE file. A very brief description is as follows:
This piece of software can be used free of charge for both academic and commercial purposes.

If you use this code, please cite the following paper:
Authors: M. Ajdari, P. Peykani Sani, A. Moradi, M. Khanalizadeh Imani, A. H. Bazkhanei, H. Asadi
Title: "Re-architecting I/O Caches for Emerging Fast Storage Devices"
 Venue: ASPLOS 2023



