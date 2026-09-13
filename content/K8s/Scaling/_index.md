---
title: "Scaling"
draft: false
---

In the context of systems administration, scaling refers to making more resources available so that an application can deal with increased load. 

## Types of scaling

Two types are always distinguished: 

- Vertical Scaling: Adding more resources in the same infrastructure
- Horizontal scaling: Adding more infrastructure

## In K8s

Kubernetes allows for manual and automatic scaling on two levels:

- Cluster infrastructure
  - Adding more worker nodes (Horizontal)
  - Adding more resources to a node (Vertical, rarely used)
- Pods
  - Adding more pods to serve requests/load (Horizontal)
  - Increasing the resources of a pod (Vertical)