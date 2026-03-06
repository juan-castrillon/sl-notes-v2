---
title: "Block Devices"
date: 2026-03-06T15:51:10+01:00
draft: false
---

Block devices are **files** that normally represent a piece of hardware that can store data (disks). These can be found under `/dev/*`

> The name block devices is given because data is written and read in blocks at a time

The main way provided in Linux to see this devices is `lsblk` (List block). Here is an example output:

```bash
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0 119.2G 0 disk 
├─sda1   8:1    0   100M 0 part /boot/efi
├─sda2   8:2    0  72.5G 0 part /media/MM/Data
└─sda3   8:3    0  46.6G 0 part /
```

- `NAME` indicates whether the devie is a disk (`sda`) or a partition (`sda1`)
- `MAJ` is a convention to identify the type of block device (ssociated with the driver responsible)
  - SATA Disk are for example typically 8, NVMe 259, 3 for Hard disk or CD ROM, etc.
