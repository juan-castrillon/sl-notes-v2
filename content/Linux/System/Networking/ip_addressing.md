---
title: "IP Addressing"
date: 2025-07-06T13:53:39+02:00
draft: false
---

An IP address uniquely identifies a device on a network.

## IPv4

IPv4 addresses are 32-bit numbers written as four octets (e.g. `192.168.1.1`).

### IPv4 Classes (Legacy)

- Class A: First octet = network ID
- Class B: First two octets = network ID
- Class C: First three octets = network ID
- Class D: Multicast
- Class E: Experimental

### NAT

Network Address Translation allows multiple devices on a private network to share a single public IP address. This is specially useful in IPv4 systems, as the number of addresses is limited:

![](/images/Linux/nat.png)



## IPv6

IPv6 addresses are 128-bit, written in hexadecimal, and use colons (e.g. `2001:0db8::1`). They vastly increase the number of available addresses and eliminate the need for NAT.



## Address Assignment

- **Static** (manual): Using `ip addr` or config files
- **Dynamic**: Using DHCP (Dynamic Host Configuration Protocol)

### Assigning an IP Address

```bash
ip addr add 192.168.1.10/24 dev eth0
```

