---
title: "Labels and selectors"
date: 2025-04-21T15:45:13+02:00
draft: false
---

In order to categorize and filter resources of all kinds, K8s uses the concept of labels and selectors. In this sense, resources like Pods, Deployment, Nodes, etc. are created with a set of labels that can then be used by a selector to "pick" resources and target the correct ones. 

Labels are normally added in the `metadata` field of objects. For example in a pod :

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: app1
    tier: frontend
spec:
  containers:
  - name: nginx
    image: nginx
```

Selectors are then used in other resources. For example a replica set

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs
spec:
  selector: # How to find which pods to manage?
    matchLabels: # Using the pod labels
      app: app1
```

