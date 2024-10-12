---
title: "Concepts"
date: 2024-10-12T11:36:45+02:00
draft: false
---


## Pods

- Pods are the smallest deployable unit in K8s. The are a "logical" grouping that encapsulates containers that are to be managed via Kubernetes. 
- Pods can contain one container (standard use case) or multiple ones that are somehow bundled together (e.g sidecar containers)
- All containers in the pod share
  - Network (can reach each other with `localhost`)
  - Storage
  - Host (co-located)
  - Schedule (lifecycles are tied to one another)
- In general, pods are thought to be volatile and replaceable. Each instance of a pod represents an instance of an app that can be scaled up/down at any point. 

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

## Deployment
