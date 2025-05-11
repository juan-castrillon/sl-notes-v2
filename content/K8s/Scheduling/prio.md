---
title: "Priority"
date: 2025-05-11T18:03:14+02:00
draft: false
---

As shown in [process]({{< ref "k8s/scheduling/process" >}}), part of the scheduling depends on the defined priority of the pods to be scheduled. To control this, k8s allows for the definition of objects called `PriorityClass` which determined how critical a pod is. 

The range of priorities that can be defined, can go from 10^9 to -2^31 (-2,147,483,648). Priority classes are also used for system components deployed (thing of the `kube-system` namespace), and these ones go from 10^9 to 2*10^9 (and maybe more).

Once defined, priority classes are global to the cluster (e.g not attached to namespaces). By default, the two priorities used for system components exist (`system-cluster-critical`, `system-node-critical`)

Very importantly, the classes allow to define how to behave with respect to lower priority pods. The options are: Preempt them (`PreemptLowerPriority`) or not (`never`) with the default being Preemption.

{{% notice style="tip" %}}
By default, all pods that do not defined a priority class, have priority 0, this can be changed assigning a priority class as default with `globalDefault`{{% /notice %}}


## Definition

To define it, the following YAML structure is used


```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
    name: my-prio
value: 1000000000
description: "Ultra high prio tasks"
preemptionPolicy: PreemptLowerPriority
globalDefault: 
```

Once defined, pods can be created referencing a class:

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: mypod
spec:
    priorityClassName: my-prio
```
