---
title: "Filesystem Architecture"
date: 2023-01-14T11:37:25+01:00
draft: false
---

The Linux file system structure is organized into a tree-like hierarchy, starting from the root directory `/`. The root directory contains several standard subdirectories, each serving a specific purpose.

{{% notice style="tip" title="Good to know" %}}
Similar information can be found using `man hier`
{{% /notice %}}

Here is a list of the standard folders in the Linux filesystem hierarchy:

- **/bin** - Binary executables for system & users. This directory contains essential command line utilities, such as `ls`, `cat`, and `cp`, that are required for basic system operation and are accessible by both the system and users.

- **/sbin** - Binary executables for system administrator only. This directory contains utilities that are necessary for system administration, such as `init`, `fdisk`, and `ip`. These utilities can only be executed by the root user or other users with administrative privileges.

- **/etc** - Configuration files for system & applications. This directory contains configuration files for the system, as well as for applications and services installed on the system. These files are often human-readable and can be edited to modify the behavior of the system and its applications.

- **/dev** - Device files for attached devices. This directory contains special files, also known as device files, that represent and provide access to the various devices attached to the system, such as hard drives, keyboards, and printers. The directory is initially empty, when not mounted. `udev` which manages devices in linux, then creates entries dynamically when devices are found

- **/lib** - Libraries for executables in `/bin` & `/sbin`. This directory contains libraries and shared objects required by the executables in the `/bin` and `/sbin` directories. Libraries are collections of code that can be reused by multiple programs, improving system efficiency.

- **/boot** - Files for system booting. This directory contains files necessary for booting the system, such as the Linux kernel, initial RAM disk, and boot loader configuration files.

- **/var** - Files that change frequently (logs, spool, temp). This directory contains files and directories that change frequently, such as logs, spool directories, and temporary files. These files are usually deleted or recreated every time the system is restarted.

- **/tmp** - Temporary files deleted on restart. This directory contains temporary files that are deleted when the system is restarted. These files are used by applications and services to store data temporarily.

- **/usr** - User-related data (apps, libs, docs, user homes). This directory contains files and directories related to users, such as user-installed applications, libraries, documentation. This directory contains non essential binaries, and has its own tree, this means, it has `/usr/bin`, `usr/sbin`, etc.

- **/home** - Home directories of users. This directory contains a subdirectory for each user on the system, which serves as that user's home directory. The home directory typically contains personal configuration files, documents, and other files specific to each user. The only exception is the `root` user, whose home is `/root`

- **/media** - Mount points for removable media. This directory contains subdirectories for mounting removable storage devices, such as USBs. Each mounted device is represented by a subdirectory in `/media`, allowing for easy access to the files and directories on the device. In modern distributions,can be named `/run`

- **/mnt** - Mount points for file systems temporarily mounted. This directory is similar to `/media`, but it is used for temporarily mounting file systems, such as network file systems, that are not meant to persist across reboots.

- **/opt** - Optional software installation. This directory is intended for the installation of optional software packages that are not part of the standard Linux distribution. Each software package is installed in its own subdirectory within `/opt`, making it easy to manage and remove the software if necessary.

- **/proc** - Process information file system. This directory is a virtual file system that provides information about the system and running processes. The files in this file system are not stored on disk like traditional files, but are generated on-the-fly by the kernel. The `/proc` file system is used to provide information about system resources, such as memory usage, system uptime, and CPU utilization, as well as information about running processes, such as their process ID, memory usage, and status.
