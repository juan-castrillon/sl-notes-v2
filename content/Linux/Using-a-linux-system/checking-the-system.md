---
title: "Checking the System"
date: 2023-02-08T18:45:27+01:00
draft: false
---

Below is a list of common operations to check the current status of a linux system

## Hardware

Some general information about the machine can be obtained by using the `uname` command. With the `-a` flag it will print:
- Kernel Name
- Node hostname
- Kernel release and version
- Processor type
- Operating system

```bash
uname -a
```

### Checking uptime

The `uptime` command can be used to determine how long has the server been "up"

```bash
uptime --pretty
```

### Memory

To check the physical available memory use:

```bash
grep MemTotal /proc/meminfo
```

However, running `free` gives a more complete overview on memory usage:

```bash
free -h
```

### CPU

The command `lscpu` displays information about the CPU architecture: 

```bash
lscpu
```

With the `extended` flag, the information can be compressed in a table

```bash
lscpu --extended
```

For more level of detail, the respective `/proc` file can be read and grepped

```bash
cat /proc/cpuinfo
```

### Disks and filesystems

## Networking
### Checking for open ports
### Checking firewalls

## Software
### Distribution
### Installed packages
### Processes


top htop | process info
df -h | filesystes
lsblk | block disks

`ss`
  - normally used with `tlpn`
  - shows open ports and interfaces
  - run with `sudo` shows the processes
  - https://www.tecmint.com/ss-command-examples-in-linux/
`nmap`
  - port scanner
  - used on the ip shows open port

`ufw`
  - firewall to manage `iptables`
