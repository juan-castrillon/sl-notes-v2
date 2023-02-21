---
title: "Checking the System"
date: 2023-02-08T18:45:27+01:00
draft: true
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

The `lsblk` command is used to display information about block devices (i.e., hard drives, SSDs, etc.) on the system. It displays information in the "lower" level of devices which may or not be mounted. 

```bash
lsblk
```

To look into disk space and utilization, the `df` command is used. This displays information about the amount of space used and avaiable in filesystems that are **mounted** in the system. 

```bash
df -h
```

Some of the most commonly used options for `df` include:
- `h`: Display disk space in a human-readable format.
- `T`: Display the filesystem type.
- `i`: Display the number of inodes (i.e., the number of files and directories) on the filesystem.

To go more into detail about the space used by particular files or directories, `du` is used. 

```bash
du [options] [file|directory]
```

Some frequently used commands are:
- `du -h dir` Shows the size of all files in the current directory in a human readable format
- `du -sh dir` Same as above, but limits the results to a single directory (instead of recursive)
- `du -ah dir` includes hidden files
- `du -h --max-depth=N dir` List the human-readable sizes of a directory and any subdirectories, up to N levels deep.

## Networking

Some tools can be used for general networking checking:

`ip` is a tool that allows to show / manipulate routing, devices, policy routing and tunnels. `ip address` or `ip a` allows to show, remove and manage the ips of the different interfaces. THe following command summarizes the interfaces in the system and their assigned IPs

```
ip -brief a 
```

### Checking for open ports
To check (or verify) open ports can be useful in determining if a service is running or not (e.g. web server). 

The first option to do this is with the `ss` (sockets statistics) tool. This tool allows to not only display information but kill socket connections. To display open ports the following command can be used

```bash
sudo ss -tulpnw
```

This will show all TCP (`t`) and UDP (`u`) ports that are open and listening (`l`). It will display the process (`p`) using them and their ports in a numeric way `n`. Finally it will display everything in `w`ide format. 

{{% notice style="info" title="Filtering by port" %}}
Is possible to use the ss command like `ss -ltpn src :1313` for example to see only the entry for the 1313 port in TCP
{{% /notice %}}

An alternative is to use `nmap`. This a very powerful tool used, among other things, to scan a network and discover hosts and services. To use it for finding out open ports, is enough to point it to the localhost ip:

```bash
sudo nmap 127.0.0.1
```
This will scan the machine and summarize the ports open and the services listening

### Checking firewalls

`ufw` (Uncomplicated Firewall) and `iptables` are both firewall tools that can be used to secure Linux systems. UFW is a frontend for iptables that simplifies the process of configuring and managing a firewall. 

To enable the firewall:

```bash
sudo ufw enable
```

Then, adding rules can be done with either `allow` or `deny` followed by the port and the protocol. If no protocol is specified it will apply for both

```bash
sudo ufw allow 80/tcp #Allow TCP connections on port 80
sudo ufw deny 22 #Deny TCP and UDP connections on port 22
sudo ufw allow out 3306/tcp #Allow only outbound TCP traffic from port 3306
```

{{% notice style="tip" title="Default" %}}
By default, if there are no allow or deny rules in `ufw`, all incoming traffic is denied, and all outgoing traffic is allowed
{{% /notice %}}

The status and the rules can be checked at any time with

```bash
sudo ufw status
```

## Software
### Distribution

Two reliable ways of checking which distribution is a machine running are:

First, the `/etc/os-release` file. This provides information about the OS in the form of variables that can be sourced. An example would be:

```bash
#!/bin/bash
# source the os-release file
source /etc/os-release
# check if the distribution is Ubuntu
if [ "$NAME" == "Ubuntu" ]; then
    echo "This is Ubuntu"
fi
# check if the distribution is CentOS
if [ "$NAME" == "CentOS Linux" ]; then
    echo "This is CentOS"
fi
```

Second, the `lsb_release` command can be used to obtain distribution information. An example below:

```bash
#!/bin/bash
# use lsb_release to get distribution information
DISTRIB_ID=$(lsb_release -si)
DISTRIB_RELEASE=$(lsb_release -sr)
# check if the distribution is Ubuntu
if [ "$DISTRIB_ID" == "Ubuntu" ]; then
    echo "This is Ubuntu"
fi
# check if the distribution is CentOS
if [ "$DISTRIB_ID" == "CentOS" ]; then
    echo "This is CentOS"
fi
```

{{% notice style="warning" title="lsb_release availability" %}}
The `lsb_release` command is not installed by default in CentOS and other distributions. Debian, Ubuntu, Mint, openSUSE and Fedora all include it. For red-hat based systems, the package `redhat-lsb-core` provides it.
{{% /notice %}}


### Installed packages

Checking the packages installed in the system depends on the family of the installed distribution. 

#### Debian based (APT)

In debian, ubuntu and related distributions, the list of installed packages can be generated in two ways:

First using the low level `dpkg` command

```bash
dpkg -l
```

Second using the higher level `apt`:

```bash
apt list --installed
```

{{% notice style="note" title="Search in sources" %}}
`apt` also offers a command to search for packages that might not be installed but are available in the configured sources. This can be done with `apt search name` or `apt-cache search name`
{{% /notice %}}

In addition, `apt show` can be used to obtain information about installed (or not installed) packages 

#### Red Hat Based (YUM)

In RedHat, CentOS and related distributions, the list of installed packages can be generated in two ways:

First using the low level `rpm` command

```bash
rpm -qa
```

Second using the higher level `yum`:

```bash
yum list installed
```

{{% notice style="note" title="Search in sources" %}}
`yum` also offers a command to search for packages that might not be installed but are available in the configured sources. This can be done with `yum search name`
{{% /notice %}}

In addition, `yum info` can be used to obtain information about installed (or not installed) packages 

### Processes


top htop | process info
### Services (Daemons)
# systemctl
used for services
enable, disable, start, stop, status

https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
