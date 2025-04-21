---
title: "Manual Scheduling"
date: 2025-04-21T15:44:48+02:00
draft: false
weight: 1
---

As part of the scheduling process, the `kube-scheduler` updates the `nodeName` field on pods. This behavior can be emulated manually to "skip" the scheduler and manually assign a pod to a node

E.g The pod below will always go to `node1`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: node1
  containers:
  - name: nginx
    image: nginx
```

## Updating running pods

Once a pod has been assigned a node, the `nodeName` field cannot be edited. To change the node, a Binding object is needed. This object (its json representation) must be sent to the pod's binding API to update the node. An example command to do this might be:

```bash
curl --header "Content-Type: application/json" --request POST --data @binding.json http://$SERVER/api/v1/namespaces/default/pods/nginx/binding
```

Where `$SERVER` is the address of the `kube-api-server`.

