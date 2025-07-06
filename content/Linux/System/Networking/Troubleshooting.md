---
title: "Troubleshooting"
date: 2025-07-06T14:48:59+02:00
draft: false
---

When network issues arise, having a set of reliable tools to diagnose and understand the problem is essential. Linux offers a variety of commands to help inspect connectivity, routing, and traffic flow.


## Common Troubleshooting Commands

### `ping` 

- Sends ICMP echo request packets to a target host to check if it is reachable
- Measures round-trip time.
- It is sometimes blocked in certain networks to avoid network scanning and hacking attacks

```bash
ping -c 4 example.com  #-c option to limit the number of pings sent
```


### `traceroute` 

- Traces the path that packets take from the source to a destination host.
- It reveals each hop (router) along the way and the time taken to reach it. 
- Useful for identifying where delays or failures occur in the network path.

### `ethtool`  

Useful for inspecting and modifying Ethernet device settings, such as speed, duplex mode, and link status. It can diagnose hardware-level issues on network interfaces.

### `netstat` and `ss`  
  
These commands provide information about active network connections, listening ports, and network statistics. `ss` is the modern replacement for `netstat`, offering faster and more detailed output.

### `tcpdump`  

A powerful packet analyzer that captures and displays network traffic on an interface. It’s invaluable for deep inspection of network packets to diagnose protocol or application-level issues.

### `iptraf`  

An interactive, console-based network monitoring tool that shows real-time traffic statistics and protocol breakdowns.

### `mtr`  

Combines the functionality of `ping` and `traceroute` by continuously sending packets and displaying the route along with latency and packet loss statistics. It’s useful for ongoing network path analysis.

### `dig`  

Used for detailed DNS queries, helpful when diagnosing name resolution issues.

### `nmap`  

A network scanner used to discover hosts and services on a network, and to check open ports and firewall settings.


