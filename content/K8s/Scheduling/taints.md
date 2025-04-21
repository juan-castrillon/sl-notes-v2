---
title: "Taints and Tolerations"
date: 2025-04-21T15:45:21+02:00
draft: false
---

When scheduling, the concept of taints and tolerations solves the following problem: 

How to make **nodes** only run certain **pods**?

{{% notice style="warning" title="Attention" %}}
It's important to note that taints and tolerations does **NOT** make pods run in certain nodes. It is a limitation on nodes. 
{{% /notice %}}

## Taints

Taints are conditions applied to nodes that describe which pods to reject. They have 3 main components:
- Key: Label key that the toleration needs to match
- Value: Label value that the toleration needs to match
- Behavior: This tells the scheduler what exactly to do:
  - `NoSchedule`: If a pod cannot tolerate the taint, it will not be scheduled in the node. If any pod is **already running** and does not match, it will keep running
  - `PreferNoSchedule`: If a pod cannot tolerate the taint, the scheduler might try to put it somewhere else, but it might end up here anyways
  - `NoExecute`: Similar to `NoSchedule` but non tolerant running pods are **evicted**

Taints are put on a node using `kubectl`:

```bash
kubectl taint nodes <node> key:value:NoExecute
```

## Tolerations

Tolerations are set on pods to "overcome" node taints, making the pod "compatible" with certain tainted nodes.  This is defined in the pod's definition:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: nginx-container
      image: nginx
  tolerations:
    - key: "app"
      operator: "Equal"
      value: "blue"
      effect: "NoSchedule"
```

A toleration "matches" a taint if:

- The keys are the same
- The effects are the same, and:
- The operator is `Exists` (in which case no value should be specified), or the operator is `Equal` and the values should be equal.