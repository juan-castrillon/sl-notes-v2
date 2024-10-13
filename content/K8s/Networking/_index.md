---
title: "Networking"
draft: false
---

## Definition

The networking model in Kubernetes is defined as follows:

![k8s network](/images/K8s/k8s_nw.png)


- Containers inside a pod have their own network namespace and can reference each other using `localhost`
- Each node in the cluster has an assigned address pool (e.g `10.244.0.0/24`), and pods within the node get assigned an IP from this pool
- All pods in the cluster are able to communicate with each other without NAT
- All pods can communicate with the nodes they are placed in or other nodes without NAT

## Implementation

Kubernetes defines how the networking should work, but does not provide an actual implementation. For this, different CNI Plugins can be used. 

The CNI model improves modularity in the Kubernetes ecosystem. Different plugins offer unique combinations of features to accommodate a wide range of use cases and environments. Any CNI plugin will provide the standard set of Kubernetes networking features but can also expand on them, such as by integrating with other network technologies and services.

Popular ones include:

- [Calico](https://docs.tigera.io/calico/latest/getting-started/kubernetes)
- [Flannel](https://github.com/flannel-io/flannel)
- [Cilium](https://cilium.io/)
- [Weave Net](https://www.weave.works/oss/net)