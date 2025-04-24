---
title: "Static Pods"
date: 2025-04-24T11:15:21+02:00
draft: false
---

K8s provides a way to "override" the scheduler and deploy pods statically. These static pods are managed directly by the `kubelet` daemon on a specific node, without the API server observing them. 

The `kubelet` automatically tries to create a mirror Pod on the Kubernetes API server for each static Pod. This means that the Pods running on a node are visible on the API server, but cannot be controlled from there. 

{{% notice style="tip" %}}
The static pod names will be suffixed with the node hostname with a leading hyphen.
{{% /notice %}}

Noticeably, static pod deployments are used by the `kubeadm` tool to deploy control plane components (e.g api server, scheduler, etc.)


## Deploying static pods

The `kubelet` read static pod definitions for a defined folder. This can either be passed as an argument `--pod-manifest-path` or as the `staticPodPath` part of the configuration file (`--config`) to the `kubelet.service`. 

{{% notice style="tip" title="Finding the path" %}}
`systemctl cat kubelet.service` can be useful to find the path. Most of the times is `/etc/kubernetes/manifests`
{{% /notice %}}

To deploy a static pod, the only required action is to create a pod definition in this folder. The `kubelet` will pick it up automatically and deploy it. Similarly, for any changes done to the file, the `kubelet` will reflect them in the deployment. 

