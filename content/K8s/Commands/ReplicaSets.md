---
title: "ReplicaSets"
date: 2025-04-12T14:28:14+02:00
draft: false
---

#### Get Replica Sets

```bash
kubectl get replicaset
kubectl get rs
```

#### Get single replica set

```bash
kubectl describe replicaset rs_name
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Scale replica set ad-hoc

```bash
kubectl scale --replicas=6 replicaset rs_name
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Destroy replica set

```bash
kubectl delete replicaset rs_name
```