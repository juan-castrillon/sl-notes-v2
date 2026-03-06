---
title: "External Storage"
date: 2026-03-06T16:38:24+01:00
draft: false
---

For server setups (specially in production environments),external storage solutions are used instead of built in disks. Here is an overview of different types:

## DAS (Direct Attached Storage)

- A DAS device is connected directly to a host (server).
- Given the direct connection is fast and performant
- For the Host OS, it is detected as a block device
- It is however dedicated to a single host

## NAS (Network Attached Storage)

- A NAS device is located apart from the hosts and communicates via networks
- Storage traffic has to go always to the network which can make it "slow"
- For the host OS, the device is exposed as a folder via protocols like NFS (see [Filesystems]({{< ref "linux/system/storage/filesystems" >}}).) or CIFS
- Ideal for shared storage between different nodes, but not recommended for "critical" uses like DBs, or OS installation where the latency might be too much

## SAN (Storage Area Network)

- A SAN device is located apart from the hosts and communicates via fiber-based dedicated connection
- For the Host OS, it is detected as a block device
- Internally storage is allocated to hosts as Logical Unit Numbers (LUNs), which represent sections of a shared storage pool presented as logical disks to the server.
- Much better performance as the other two