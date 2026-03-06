---
title: "Filesystems"
date: 2023-01-14T11:41:41+01:00
draft: false
---

## What is it?

A file system in Linux is the way in which files are stored, organized, and managed on a Linux operating system. It is responsible for managing the data on a storage device, such as a hard disk or solid-state drive, by dividing it into multiple sections or partitions. The file system determines the structure and organization of the files, as well as the methods used to access and modify them. 

Once mounted in a directory, it acts as "interface" between the os and the physical disk. It determines and abstracts how to interact with the block device

{{% notice style="note" title="Info" %}}
The most commonly used file systems in Linux are the `ext4`, `btrfs`, and `xfs` file systems. The file system chosen depends on the specific requirements of the system, such as performance, scalability, and reliability.
{{% /notice %}}

## Creating a filesystem

Diverse utilities `mkfs.xxx` can be used to create a file system on a partition (or disk). For example:

```bash
mkfs.ext4 /dev/sdb1
```

## Mounting filesystems

Different file systems are mounted on the filesystem tree. The mount points are just directories in which the new filesystem will live.

The utility `mount` is used for this task:

```bash
sudo mount /dev/sda5 /home #Mounts the filesystem in the sda5 device(partition) in /home
sudo umount /home #Dismounts the filesystem
```

This is a temporal way of mounting a filesystem and will get unmounted in reboot. In order to make it permanent, the `etc/fstab` file needs to be modified. 

Add a new line to the file with the following format:

```bash
<device> <mount point> <file system type> <options> <dump> <pass>
```

For example, to mount the file system located at `/dev/sdb1` with the file system type `ext4` to the mount point `/mnt/data`, the line would be:

```bash
/dev/sdb1 /mnt/data ext4 defaults 0 0
```

The fields in this case represent:
- `/dev/sdb1`: Filesystem
- `/mnt/data:` Mountpoint
- `ext4`: Filesystem Type
- `defaults`: Options to control how the filesystem is mounted. Common are also `rw` or `ro` for read only
- `0`: DUMP control (Mostly legacy, was used to enable a backup, nowadays mostly `0`)
- `0`: PASS control (used by the `fsck` program to determine the order in which filesystem checks are done at reboot time. The root filesystem should be specified with `1`, and other filesystems should have a `2` or `0` to ignore)

More information is available in `man fstab`

{{% notice style="tip" title="Good to know" %}}
`mounted` alone, as well as `df -Th` will show all presently mounted filesystems
{{% /notice %}}

## NFS

A special kind of filesystem is a **N**etwork **F**ile **S**ystem. The Network File System (NFS) is a protocol that allows a computer to share its files with other computers over a network. NFS enables seamless access to remote file systems as if they were local, allowing users to access and manage files on remote systems with the same ease as they do on their own computer.

It has a server and a client side

### Server
On the server, `nfs` runs a a daemon, and allows to share a directory in the server’s filesystem via NFS (with a network address)

```bash
sudo systemctl start nfs # Starts the NFS daemon
```

On the `/etc/exports` file, the directories that are going to be shared are typed in. For example `/projects *(rw)` means that the `/projects` directory in the server will be shared (with read and write accesses).

Using `exportfs -av` notifies Linux of the changes. The NFS daemon can also be reset, and set to start on boot.

### Client

On the client, the filesystem is mounted like any other (Is also possible to modify fstab to boot with the filesystem mounted)

```bash
sudo mount servername:/projects /mnt/nfs/projects
```