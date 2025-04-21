---
title: "Node Selectors and Affinity"
date: 2025-04-21T15:45:29+02:00
draft: false
---

As opposed to [taints]({{< ref "k8s/scheduling/taints" >}}) which prevents pods from going to nodes, node labels are used either with selector or affinity definitions to make a pod run in a certain node. 

## Node Selectors

In a simple scenario, node selector definitions (part of the pods YAML) are used to match labels in the nodes. The example below binds the pod with nodes that have the `size=Large` label

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  nodeSelector:
    size: Large
```

## Node Affinity

For more complex scenarios, node affinity definitions are used. These also work based on labels but allow for more complex rules. 

It has two types:

- `requiredDuringSchedulingIgnoredDuringExecution`: The scheduler can't schedule the Pod unless the rule is met. This functions like `nodeSelector`.
- `preferredDuringSchedulingIgnoredDuringExecution`: The scheduler tries to find a node that meets the rule. If a matching node is not available, the scheduler still schedules the Pod somewhere. In here a `weight` can be defined that is added everytime a soft condition is met in a node. In that sense the highest scoring node might be chosen

In its more complex syntax, it also allows more complex matching expressions with an `operator` field (`In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt` and `Lt`) and array inputs. Here is the same example as above:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: In
                values:
                  - Large
```