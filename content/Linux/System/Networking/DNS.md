---
title: "DNS"
date: 2025-07-06T13:43:33+02:00
draft: false
---

DNS stands for Domain name resolutions and is a system that enables the use of domains (names) to refer to nodes in a network instead of using IP addresses. 

It works by establishing a record list, which maps names (domains) to IPs

In Linux, systems normally have several "levels" of DNS resolution:

## DNS Configuration

### Local Resolution

#### `/etc/hosts`

In all linux systems, the file `/etc/hosts` is consulted for local IP -> Name mapping.

This file takes priority over any external DNS. In case of any record appearing in multiple servers in the chain, the one here will have priority (by default, see below)

```text
127.0.0.1   localhost
192.168.1.10   dev-server
```

{{% notice style="note" title="Resolution Priority" %}}
The file `/etc/nsswitch.conf` can be used to configure the order of resolution:

```text
hosts: files dns
```

In case of the config above, `/etc/hosts` will have priority over any external DNS server
{{% /notice %}}


### Centralized Resolution

In real systems, depending on local resolution configured in each server does not scale well and becomes very difficult to maintain. A better option is to manage records in a central server, and configure all nodes in the network to consult it for any DNS queries. 

Once set, if a hostname cannot be resolved locally, the system forwards the request to the DNS server.

This is traditionally controlled with the file `/etc/resolv.conf` which contains nameservers and search domains (gets automatically added to any queries):

```text
nameserver 8.8.8.8
nameserver 1.1.1.1
search home.local
```

{{% notice style="tip" %}}
In modern systems is now more common use **`systemd-resolved`** to manage name resolution instead of `resolv.conf`.

On such systems, `/etc/resolv.conf` is often a **symlink** to a dynamically managed file (like `/run/systemd/resolve/stub-resolv.conf`). Manual edits to `/etc/resolv.conf` may be ignored or overwritten. 

DNS settings can typically be configured via **NetworkManager**, **netplan**, or **systemd-networkd**, depending on the system setup.
{{% /notice %}}


## DNS Records

DNS records define how domain names map to IP addresses, services, and other information. Here are the most commonly used types:

### A record

- Maps a domain to an IPv4 address
- Example

```text
example.com.   IN   A     93.184.216.34
```

### AAAA record

- Maps a domain to an IPv6 address
- Example

```text
example.com.   IN   AAAA    2606:2800:220:1:248:1893:25c8:1946
```

### CNAME

- Creates an alias from one domain to another.
- Example:
 
```text
www.example.com.  IN  CNAME  example.com.
```
When resolving `www.example.com`, the DNS server looks up `example.com` instead. Useful for pointing multiple subdomains to the same canonical source.

## Domains

![](/images/Linux/domains.jpg)

When a request such as `apps.google.com` is made, the DNS server will forward the query if it does not have a record for it:

1. A root DNS server directs the request to a DNS server responsible for the .com domain.
2. The `.com` DNS server forwards the request to Google’s DNS server.
3. Google’s DNS server returns the IP address for the service.

## Tools for DNS in Linux

Two essential tools for DNS troubleshooting and inspection on Unix-like systems are **`dig`**, **`nslookup`**. **`hosts`**. They help query DNS servers and display detailed information about how domain names are resolved.

{{% notice style="warning" %}}
All tools do not consider entries in `etc/hosts`
{{% /notice %}}


### `dig`: Domain Information Groper

`dig` is a flexible and powerful command-line tool to perform DNS lookups. It's the preferred tool for advanced diagnostics.

#### Basic Usage

```bash
dig example.com
```

This returns:
- A record (IPv4 address) by default
- Query time
- Authoritative/non-authoritative status

#### Query a Specific Record Type

```bash
dig example.com A      # IPv4 address
dig example.com AAAA   # IPv6 address
dig example.com MX     # Mail server
dig example.com TXT    # Text records
dig example.com CNAME  # Alias
```

#### Use a Specific DNS Server

```bash
dig @1.1.1.1 example.com
```


#### Short Answer Only (for scripting or readability)

```bash
dig +short example.com
```


### `nslookup`: Name Server Lookup

nslookup is an older utility, still widely available and useful for quick checks.

#### Basic Usage

```bash
nslookup example.com

```
Returns the default DNS server and the A record of the domain.

#### Query a Specific Record Type

```bash
nslookup -query=MX example.com
```

#### Interactive Mode

You can launch nslookup in interactive mode:

```bash
nslookup
> set type=TXT
> example.com
> exit
```

#### Use a Specific DNS Server

```bash
nslookup example.com 8.8.8.8
```

### `host`

The `host` command is a lightweight and user-friendly utility for performing DNS lookups. It’s simpler than `dig` and often faster for quick queries.

#### Basic Usage

```bash
host example.com
```

This returns the default A (IPv4) record(s) for the domain.


#### Query Specific Record Types

```bash
host -t MX example.com     # Mail exchange records
host -t AAAA example.com   # IPv6 address
host -t TXT example.com    # Text records
host -t NS example.com     # Name servers
```

You can also use -a for a full query (equivalent to ANY):

```bash
host -a example.com
```

#### Query a Specific DNS Server

```bash
host example.com 1.1.1.1
```

