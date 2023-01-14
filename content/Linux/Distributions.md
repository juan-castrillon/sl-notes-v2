---
title: "Distributions"
date: 2023-01-04T22:32:09+01:00
weight: 1
draft: false
---

The Linux kernel is the core of the operating system. A full Linux distribution consists of the kernel plus a number of other software tools for file-related operations, user management, and software package management

![image](https://user-images.githubusercontent.com/64461123/117853592-e6a80700-b288-11eb-8063-22c579209436.png)

## Distribution Families

There are more than 200 distributions. The most commonly used can be categorized in three families:

- Red Hat Family Systems (including CentOS and Fedora)
- SUSE Family Systems (including openSUSE)
- Debian Family Systems (including Ubuntu and Linux Mint).

### Red Hat

Some of the key facts about the Red Hat distribution family are:

- Fedora serves as an upstream testing platform for RHEL.
- CentOS is a close clone of RHEL, while Oracle Linux is mostly a copy with some changes (in fact, CentOS has been part of Red Hat since 2014). CentOS 8 has reached end of life while CentOS 7 will do it in 2024
- A heavily patched version 3.10 kernel is used in RHEL/CentOS 7, while version 4.18 is used in RHEL/CentOS 8.
- It supports hardware platforms such as Intel x86,  Arm, Itanium, PowerPC, and IBM System z.
- It uses the `yum` and `dnf` RPM-based yum package managers to install, update, and remove packages in the system.
- RHEL is widely used by enterprises which host their own systems.

### SUSE

Some of the key facts about the SUSE family are listed below:

- SUSE Linux Enterprise Server (SLES) is upstream for openSUSE.
- Kernel version 4.12 is used in openSUSE Leap 15.
- It uses the RPM-based `zypper` package manager to install, update, and remove packages in the system.
- It includes the YaST (Yet Another Setup Tool) application for system administration purposes.
- SLES is widely used in retail and many other sectors.

### Debian

Some key facts about the Debian family are listed below:

- The Debian family is upstream for Ubuntu, and Ubuntu is upstream for Linux Mint and others.
- Kernel version 4.15 is used in Ubuntu 18.04 LTS.
- It uses the DPKG-based APT package manager (using `apt`, `apt-get`, `apt-cache`, etc.) to install, update, and remove packages in the system.
- Ubuntu has been widely used for cloud deployments.
- While Ubuntu is built on top of Debian and is GNOME-based under the hood, it differs visually from the interface on standard Debian, as well as other distributions.