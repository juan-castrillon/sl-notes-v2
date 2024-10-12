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

Orchestration solutions tackle this and many other scenarios and abstract container management. These include Kubernetes, but also things like [Nomad](https://www.nomadproject.io/), [Mesos](https://mesos.apache.org/) or [Docker Swarm](https://docs.docker.com/engine/swarm/)


## Architecture

### Cluster Architecture

In kubernetes, different machines organize in a **cluster**. A Kubernetes cluster consists of a control plane (master node) plus a set of worker machines, called nodes, that run containerized applications. Every cluster needs at least one worker node in order to work. 

- **Nodes**: This machines run the actual workloads. They have a container runtime that allows to run containers in them. 
- **Master**: This machines manage the cluster, store information about its workers and monitors them. They are in charge of receiving the workloads and dividing them in the workers, as well as all parts of orchestration (moving the load, replication, etc.)

### Components

K8s is composed of the following components, that reside in either master or node machines:

In the masters:

- **API Server**: Provides a single interface that allows to control the cluster. CLIs, tools, UIs and users use this to interact with the cluster (like `kubectl`)
- **etcd**: Distributed Key value store that is used to store cluster information.
- **Scheduler**: Component that distributes the work in the different nodes. It takes different factors like resource usage, constraints, among others into consideration
- **Controller Manager**: Brains of the operation. Is in charge of controllers which monitor containers/nodes and act accordingly to always have a desired state (Similar to a PID controller)

In the nodes:

- **Container runtime**: Software used to run containers. Traditionally used `docker`, but recently supports only those who implement the [CRI](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-node/container-runtime-interface.md) interface. These include `containerd`, `cri-o` among others
- **kubelet**: Agent that runs in all nodes and interacts with the api-server in the masters. It manages and monitors the containers and the nodes. 

![arch](/images/K8s/kubernetes-cluster-architecture.svg)