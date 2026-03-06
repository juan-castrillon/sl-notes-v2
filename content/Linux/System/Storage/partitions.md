---
title: "Partitions"
date: 2026-03-06T15:52:09+01:00
draft: false
---

Partitions are separated “logical drives” or segments inside a single (or more) real drives, but appear as different drives to the OS. Data is stored into different partitions for many reasons, including security or backup. 

In a linux system they can be seen with `lsblk` or `fdisk -l <device>`

## Concept

### Types

There is 3 different types:

- **Primary Partition**: Used for booting an operating system. Traditionally, disks could have a maximum of four primary partitions.
- **Extended Partition**: Acts as a container for logical partitions; it cannot be used directly.
- **Logical Partition**: Created within an extended partition to bypass the four primary partition limitation.

### Partition Scheme

A partitioning scheme, or partition table, defines how these partitions are organized on a disk. Two main schemas exists:

#### MBR (Master Boot Record)

- Traditionally used by old 
- Limited to 4 primary partitions and disks of max 2TB

#### GPT (GUID Partition Table)

- No theoretical limit on primary partitions (OS implement one most of the times, e.g for RHEL is 128)
- No disk size limit


## Creating partitions

Several tools can be used to create partitions in a disk. Traditionally `fdisk` (now the newer gpt focused `gdisk`) or `parted`

Example with `gdisk`

```bash
gdisk # Opens interactive menu
? # See all commands
n # Create new partition
w # Write partition table
```