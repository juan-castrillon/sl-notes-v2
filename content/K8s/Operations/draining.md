---
title: "Draining and cordoning"
date: 2026-09-14T17:02:30+02:00
draft: false
---

Sometimes, the underlying k8s nodes need to be restarted or maintaned. In this cases, workloads running in the node will be handled by k8s in the following way:

- If the node is "down" for less than 5 min, the pods will be restarted in the same node. This time is configurable as pod eviction timeout. 
- If it lasts more than that, pods are terminated (dead). If they are part of a replica set they will be replicated on other node. Single pods, not controller by replication controllers will just die

## Draining and Cordoning

To avoid this situation, nodes can be drain before they go down. This effectively moves all workloads to different nodes in the cluster and cordons the node

```bash
kubectl drain node1 --ingnore-daemonsets
```

A node is considered "cordoned" when no pods can be placed on them (marked as unschedulable). 
This can be undone after restarting the node:

```bash
kubectl uncordon node1
```

It can also be used without draining to just make sure no new pods come to a pod

```bash
kubectl cordon node1
```
