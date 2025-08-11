---
title: "Iptables"
date: 2025-08-11T16:26:21+02:00
draft: false
---

**IPTables** is a built-in Linux firewall tool that controls how network traffic is handled by the kernel. It acts as an **internal firewall**, filtering packets based on defined rules and chains.

## Listing and Understanding Rules

One can view the current firewall configuration with:

```bash
iptables -L
```

By default, most Linux systems have policies set to **ACCEPT**, meaning traffic is allowed unless a rule explicitly blocks it.

## The Three Main Chains

IPTables rules are grouped into **chains**, each responsible for different traffic flows:

* **INPUT** – Incoming traffic *to* the local system.
* **FORWARD** – Traffic passing *through* the system (common in routers or gateways).
* **OUTPUT** – Outgoing traffic *from* the local system.

When a packet reaches a chain, it moves through the list of rules in order. If a rule matches, it can take an action (e.g. `ACCEPT` or `DROP`). If no rule matches, the chain’s default policy is applied.


## Creating Rules

Rules can match by **source**, **destination**, **protocol**, and **port**.

Example: Allow incoming SSH from a specific IP:

```bash
iptables -A INPUT -p tcp -s 192.168.0.12 --dport 22 -j ACCEPT
```

Here:

* `-A` – Add rule to the bottom of the chain (`-I` inserts at the top).
* `-p tcp` – Match TCP protocol.
* `-s` – Source address.
* `--dport 22` – Destination port 22 (SSH).
* `-j ACCEPT` – Jump to the ACCEPT target (allow traffic).

{{% notice style="warning" title="Rule order" %}}
Rule order matters. If a packet matches an earlier rule, later rules are skipped.
{{% /notice %}}


## Deleting Rules

One can delete a rule by its position number:

```bash
iptables -D OUTPUT 5
```

This removes rule number 5 from the OUTPUT chain.