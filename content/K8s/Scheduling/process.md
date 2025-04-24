---
title: "Scheduler Process"
date: 2025-04-24T12:28:27+02:00
draft: false
---

The default `kube-scheduler` works in the following way:

1. When a pod is submitted to the scheduler, it enters a scheduling queue along with other pending pods. 
2. Filter Phase: Nodes that cannot meet the pod's resource requirements (e.g., nodes lacking 10 CPUs) are filtered out.
3. Scoring Phase: Remaining nodes are scored based on resource availability after reserving the required CPU. For example, a node with 6 CPUs left scores higher than one with only 2.
4. Binding Phase: The pod is assigned to the node with the highest score.

In each of the phases, logic and decision making is implemented by plugins

### Scheduling Plugins

The image below shows different plugins that work in different stages of the scheduling pipeline:

![scheduling](/images/k8s/k8s_scheduling.png)

For example:

- **Priority Sort Plugin**: Sorts pods in the scheduling queue according to their priority.
- **Node Resources Fit Plugin**: Filters out nodes that do not have the needed resources.
- **Node Name Plugin**: Checks for a specific node name in the pod specification and filters nodes accordingly.
- **Node Unschedulable Plugin**: Excludes nodes marked as unschedulable.
- **Scoring Plugins**: During the scoring phase, plugins (such as the `Node Resources Fit` and `Image Locality` plugins) assess each node's suitability. They assign scores rather than outright rejecting nodes.
- **Default Binder Plugin**: Finalizes the scheduling process by binding the pod to the selected node.

A complete list of default plugins can be found [here](https://kubernetes.io/docs/reference/scheduling/config/#scheduling-plugins)

Going deeper, K8s scheduling framework, provides "extension points" to which plugins "plug". This is the entry point for default plugins, but can also be used by custom written plugins to implement missing functionality. These extension points are defined in different stages of the pipeline :

![ext_scheduling](/images/K8s/k8s_scheduling_ext.jpg)

More info about the particular extension points can be seen in the [docs](https://kubernetes.io/docs/concepts/scheduling-eviction/scheduling-framework/)