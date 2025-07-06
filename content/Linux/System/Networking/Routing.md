---
title: "Routing"
date: 2025-07-06T14:35:36+02:00
draft: false
---

Routing moves packets between networks. A **router** connects two or more networks and has IP addresses on each.


## Routing Table

A **routing table** is a set of rules stored in a device (like a computer or router) that tells the system **where to send network packets** based on their destination IP addresses. Each entry in the routing table specifies:

- A destination network or host IP range
- The **next hop** (the next device to send the packet to)
- The network interface to use
- Additional metadata such as metrics or priority

This table allows devices to forward packets not just within their own local network but also across interconnected networks.

In practice: 

- **Router:** A device that connects two or more networks, having multiple IP addresses (one per connected network). It uses its routing table to decide where to forward incoming packets.

- **Gateway:** Often called the "door" to a network (like a room), a gateway is the device that routes traffic from a local network to other networks or the internet. The gateway’s IP is usually configured on hosts as the **default gateway**.

### Viewing the Routing Table

```bash
ip route
# or legacy
route
```

### Adding a Route

```bash
ip route add 10.0.0.0/24 via 192.168.1.1
```

> Route all packages that go to `10.0.0.0/24` via the device in my network `192.168.1.1`

### Default Gateway

Defines where to send traffic destined for unknown networks.

```bash
ip route add default via 192.168.1.1
```
