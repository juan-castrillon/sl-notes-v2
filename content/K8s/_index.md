---
title: "Kubernetes"
draft: false
---

Kubernetes in a container orchestration tool that allows easy configuration, deployment and management of high volume containerized workload and services. 

It was developed by Google,first as an internal product and then made public as part of the Linux Foundation.

## Why Orchestration? 

When dealing with containers in production, normally deployment conditions and dependencies are complex. These can include:

- Multiple instances required
- Dynamic scaling required (More use, more instances)
- Complex inter-container interaction required
- Inter-container dependencies (One needs another one to work)
- Resource Management
- Load distribution
- Reliability (if one container goes down another should come up)
- Multiple hosts

Orchestration solutions tackle this and many other scenarios and abstract container management. These include Kubernetes, but also things like [Nomad](https://www.nomadproject.io/), [Mesos](https://mesos.apache.org/) or [Docker Swarm](https://docs.docker.com/engine/swarm/).

