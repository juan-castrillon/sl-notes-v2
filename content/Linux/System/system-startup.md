---
title: "System Startup"
date: 2023-01-04T22:46:37+01:00
weight: 1
draft: true
---

## The boot process

In linux, the boot process occurs when initiating the system. It goes from the moment the computer is powered on until the UI is fully operational and ready.

This is a sequential Process

![image](https://user-images.githubusercontent.com/64461123/117857331-ef9ad780-b28c-11eb-9a0f-7dacaa2b45f9.png)

### 1. BIOS

- Basic Input Output System
- Initializes the hardware (including monitor and keyboard)
- Tests the main memory
- Normally installed in a ROM in the motherboard

### 2. Boot Loader & Kernel

- First Stage: Master Boot Record (MBR)  examines the partition table and finds a bootable partition. Also finds a second-stage bootloader (e.g. GRUB) and loads in into RAM
- Second Stage: Programs like GRUB allow to choose the OS. Once decided, it loads the kernel and the initial RAM disks (in RAM) and passes control to the kernel. (Kernel first job is to decompress itself)
- When the kernel is loaded in RAM, it initializes and configures the computer’s memory and also configures all the hardware attached to the system.
- Second stage bootloaders are located in `/boot`
- Some second-stage bootloaders are GRUB (for GRand Unified Boot loader), ISOLINUX (for booting from removable media), and DAS U-Boot (for booting on embedded devices/appliances)

### 3. Initial RAM Disk `initramfs`

- Contains programs and binary files that perform all actions needed to mount the proper root filesystem
- After the root filesystem has been found, it is checked for errors and mounted.
- At boot time, the boot loader loads the kernel and the initramfs image into memory and starts the kernel. The kernel checks for the presence of the initramfs and, if found, mounts it as `/` and runs `/sbin/init`.

### 4. `/sbin/init`

- init handles the mounting and pivoting over to the final real root filesystem.
- Normally a shell script.
- Is the parent process of nearly all processes
- Near the end of the boot process, init starts a number of text-mode login prompts. In case of an OS with a GUI, then this is loaded and displayed instead


## `/sbin/init` and Services

Apart from being the initial process, the `init` script is also responsible for:
- Keeping the system running (Managing other processes, cleaning up after them, etc)
- Shut down cleanly

Methods for this startup are `systemd` and `Upstart`

### `systemd`

- Current systems use `systemd` instead of `init` because it simplifies the init process and makes it faster (parallel service execution instead of sequential)
- Complicated startup shell scripts are replaced with simpler configuration files
- `/sbin/init` now just points to `/lib/systemd/systemd`;

Some commands are:

Starting, stopping, restarting a service (using nfs as an example) on a currently running system:
```sh
sudo systemctl start|stop|restart nfs.service
```
Enabling or disabling a system service from starting up at system boot:
```sh
sudo systemctl enable|disable nfs.service
```