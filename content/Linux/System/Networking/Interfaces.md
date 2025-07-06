---
title: "Interfaces"
date: 2025-07-06T14:42:43+02:00
draft: false
---

In the world of networking, a **network interface** is a crucial concept. It represents the physical or virtual point of connection between a device (like a computer, server, or router) and a network. Think of it as a doorway through which data enters and leaves the device.

A network interface can be:

- A **physical interface**, such as an Ethernet port or a Wi-Fi adapter.
- A **virtual interface**, created by software, like loopback interfaces (`lo`) or virtual network devices used in virtualization or containerization.

Each interface acts as a **channel** linking the device to the network. It has its own hardware address (MAC address) and can be assigned one or more IP addresses. 


## Viewing Network Interfaces

On Linux systems, the command to view all network interfaces and their status is:

```bash
ip link show
```

This lists all interfaces along with their current state (up or down), MAC address, and other details.

To see the IP addresses assigned to interfaces, use:

```bash
ip addr show
```

This shows each interface with its IPv4 and IPv6 addresses, subnet masks, and other configuration details.


### Assigning IP Addresses

IP addresses can be assigned manually or automatically via DHCP. To assign an IP address manually to an interface, the command is:

```bash
ip addr add 192.168.1.100/24 dev eth0
```

This command assigns the IP address `192.168.1.100` with a subnet mask of `255.255.255.0` to the interface named `eth0`.


### Bringing Interfaces Up or Down

Interfaces can be enabled or disabled with commands like:

```bash
ip link set eth0 up
ip link set eth0 down
```

Bringing an interface down disconnects it from the network until it is brought back up.



### Interfaces and Network Configuration Files

On Debian-based systems, network interface configurations are traditionally found in `/etc/network/interfaces` or managed by tools like NetworkManager, `nmcli`, or `nmtui`. On Red Hat and SUSE systems, configurations reside under `/etc/sysconfig/network-scripts/`.

Modern Linux distributions often use **NetworkManager**, which simplifies interface management, especially for wireless connections and dynamic configurations.
