---
title: "Pods"
date: 2025-04-12T14:28:04+02:00
draft: false
---

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Run pod ad-hoc

```bash
kubectl run pod_name --image image_name
```

#### Get all pods

```bash
kubectl get pods
kubectl get pods -o wide # Adds more info like ip
```

#### Get single pod

```bash
kubectl describe pod pod_name
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Destroy pod

```bash
kubectl delete pod pod_name
```