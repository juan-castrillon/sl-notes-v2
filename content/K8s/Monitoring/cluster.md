---
title: "Cluster Components"
date: 2025-04-26T16:31:00+02:00
draft: false
---

K8s does not offer monitoring out of the box for its components. Multiple solutions like Prometheus, datadog, etc can be integrated.

## `metrics-server`

Altough not a part of the cluster by default, K8s provides to option to create a limited [resource metrics pipeline](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/)/ 

This pipeline provides a limited set of metrics related to cluster components such as the `HorizontalPodAutoscaler` controller, as well as the `kubectl to`p utility. These metrics are collected by the lightweight, short-term, in-memory `metrics-server`.

`metrics-server` discovers all nodes on the cluster and queries each node's `kubelet` for CPU and memory usage. The agent then pulls the information either from the underlying OS or using something like [cAdvisor](https://github.com/google/cadvisor) to pull pod (container specific metrics)

The [metrics-server](https://github.com/kubernetes-sigs/metrics-server) is a set of K8s components (Deployment, Service, etc) that can be directly installed with:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

By then, usage statistics can be seen with

```bash
kubectl top node
kubectl top pod
```

{{% notice style="warning" title="Attention" %}}
Metrics Server is meant only for autoscaling purposes. For example, don't use it to forward metrics to monitoring solutions, or as a source of monitoring solution metrics. In such cases one can collect metrics from Kubelet `/metrics/resource` endpoint directly.
{{% /notice %}}



