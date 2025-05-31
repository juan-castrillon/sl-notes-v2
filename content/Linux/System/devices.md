---
title: "Devices"
date: 2025-05-31T20:22:03+02:00
draft: false
---

Linux interacts with attached hardware mounting it as device file (See [file types]({{< ref "linux/system/files/types" >}}))

## Device creation process

When a new device is attached, the corresponding device driver in the Linux kernel identifies the state change and generates a `uEvent`. This event is forwarded to the user-space device manager daemon, `udev`, which then dynamically creates a device file under the `/dev` filesystem for the new device.

## Accessing devices information

### Accessing logs

The kernel logs can be inspected for logs about device attachment, errors, etc. This can be done for example with

```bash
dmsg
```

### UDEV information

One can query `udev` about a certain device:

```bash
udevadm info --query=path --name=/dev/sda5
```

A "live monitor" can also be put in place to see real time `udev` signals and kernel messages

```bash
udevadm monitor
```

### PCI device information

One can query specifically the PCI devices attached. Normally these are all devices that are not storage like mouse, ethernet card, wifi card, keyboard, etc:

```bash
lspci
```

### Block device information

In the same way, block devices (normally storage) can be listed:

```bash
lsblk
```

### General information

Finally detailed information on the hardware configuration of the machine is also available. This can be a bit too much but can report exact memory configuration, firmware version, mainboard  configuration,  CPU version and speed, cache configuration, among others:

```bash
lshw
```