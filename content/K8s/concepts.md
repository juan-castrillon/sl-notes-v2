---
title: "Concepts"
date: 2024-10-12T11:36:45+02:00
draft: false
---


## Pods

Pods are the smallest deployable unit in K8s. They are a "logical" grouping that encapsulates containers that are to be managed via Kubernetes. 

Pods can contain one container (standard use case) or multiple ones that are somehow bundled together (e.g sidecar containers). All containers in the pod share:
- Network (can reach each other with `localhost`)
- Storage
- Host (co-located)
- Schedule (lifecycles are tied to one another)

> In general, pods are thought to be volatile and replaceable. Each instance of a pod represents an instance of an app that can be scaled up/down at any point. 

### YAML Definition

Like every other K8s element, a pod can be created using `kubectl`, but the recommended way to do it is using a YAML definition. The same fields are common to all elements: `apiVersion`, `kind`, `metadata` and `spec`. In the case of a pod, here is a short example

```yaml
apiVersion: v1 # For pods is always v1
kind: Pod
metadata:
  name: nginx-pod # Name of the pod, only valid if created standalone
  labels: # KV pairs that can be used to separate pods from each other
    app: nginx 
spec:
  containers:
    - name: nginx-container
      image: nginx # Image to pull from docker registry (or private one)
```


## ReplicaSet

`ReplicaSets` are kubernetes objects used to maintain a stable set of replicated pods running within a cluster at any given time. Different instances of a pod are called *replicas* and this objects manage them so that a desired number of them are running at all times (can also be 1 or 0)

> Legacy k8s used `ReplicationController` objects for this purpose. This has been deprecated in favor of `ReplicaSet` and its use is not recommended

A `ReplicaSet` has three main features: a matcher to detect which pods to manage, a pod `template` for creating new pods whenever existing ones fail, and a `replica` count for maintaining the desired number of replicas that the controller is supposed to keep running. A `ReplicaSet` also works to ensure additional pods are scaled down or deleted whenever an instance with the same label is created.

Finally, these controllers can be used with existing pods (created before the replica set). In this case, matching pods will be counted towards the `replica` count. 

### YAML Definition

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs
  labels:
    app: nginx
spec:
  selector: # How to find which pods to manage?
    matchLabels: # Using the pod labels
      app: nginx
  replicas: 4 # 4 Instances must be running at all times (including existing ones)
  template: # Under here, a normal YAML definition for a pod is used
    metadata:
      name: nginx-pod # Does not matter much, pod names will start with the replica set name
      labels:
        app: nginx # Make sure label matches the matcher
    spec:
      containers:
        - name: nginx-container
          image: nginx
```


## Deployment
