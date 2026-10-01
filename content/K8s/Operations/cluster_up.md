---
title: "Cluster Upgrade"
date: 2026-09-15T17:01:53+02:00
draft: false
---

Kubernetes, and all the components that integrate it, need to be updated regularly to keep up with bug fixes, new features and security fixes. 

## Versioning and when to update

K8s components can work with different versions, however there are some rules:

- Nothing can have a higher version than the API Server
- Controller manager and scheduler can be one minor version below
- Kubelet and kubeproxy can be up to 3 minor versions below
- Kubectl can be between 1 below and 1 over

In the same way, only the 3 latest minor releases are officially supported by k8s at any time. 

{{% notice style="info" title="" %}}
The official recommendation is to always update one minor version at a time
{{% /notice %}}


## Updating a cluster

In general, for both cluster "installation types" the general logic stays the same:

1. Take the control plane nodes out
   - This will make admin components down but not workloads
   - As admin components are down, dying workloads will **not** be recreated (no controllers) but they will keep running
2. Do each worker node
   - Each node can be drained to move the workloads
   - Other strategies involve doing all at the same time (downtime) or adding new nodes and removing the old ones

### `kubeadm` clusters

K8s provides official [documentation](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/) in the procedure. Here is the summary:

1. In the control node, update `kubeadm` so it supports the target version (See first with `kubeadm upgrade plan`)

```bash
apt update
apt cache madison kubeadm
apt install kubeadm=x.x.x
```

2. Drain the node

```bash
kubectl drain controlplane
```

3. Plan and apply the upgrade

```bash
kubeadm upgrade plan vx.x.x
kubeadm upgrade apply vx.x.x
```

4. Update kubelet and kubectl

```bash
apt install kubelet=x.x.x kubectl=x.x.x
systemctl daemon-reload
systemctl restart kubelet.service
```

5. Uncordon node

```bash
kubectl uncordon controlplane
```

6. Repeat for every control node
7. For each worker then 

```
apt update
apt cache madison kubeadm
apt install kubeadm=x.x.x
kubeadm upgrade node
apt install kubelet=x.x.x
systemctl daemon-reload
systemctl restart kubelet.service
```

8. Verify

```bash
kubectl get nodes
```
