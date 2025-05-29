---
title: "Multi-Container Pods"
date: 2025-05-29T17:42:03+02:00
draft: false
---

It is clear from the `spec.containers` being an array, that a pod can be defined with multiple containers inside. Two or more containers that are in the same pod share:

- **Lifecycle**: Created and terminated together
- **Network space**: All containers share a network space, and can find each other using `localhost`
- **Storage volumes**: ALl containers have access to the same volumes which can be ued to transfer files between them

This configuration is common to enable patterns like sidecar containers (e.g logging, nw management).

{{% notice style="warning" %}}
When two or more containers are part of a pod, they are expected to live equally. That means that if any of the container fails or exits, the pod is terminated (or restarted). For different lifecycles see below
{{% /notice %}}

## Init Containers

K8s introduces the concept of init containers for containers that do not live equally but must be in the same pod. In this sense, an init container is one that performs a task and finishes before the main container(s) start. 

When defining multiple init containers they run in sequential order according to their definition. When they are **all** finished, the main one(s) start.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: \['sh', '-c', 'echo The app is running! && sleep 3600'\]
  initContainers:
  - name: init-myservice
    image: busybox
    command: \['sh', '-c', 'git clone  ;'\]
```

