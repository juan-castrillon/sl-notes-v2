---
title: "Pods"
date: 2025-04-12T14:28:04+02:00
draft: false
---

#### Get all pods

```bash
kubectl get pods
kubectl get pods -o wide # Adds more info like ip
```

#### Get single pod

```bash
kubectl describe pod pod_name
```

#### Generate POD Manifest YAML file

```bash
kubectl run pod_name --image=img --dry-run=client -o yaml
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Run pod ad-hoc

```bash
kubectl run pod_name --image image_name
kubectl run pod_name --image=image_name --labels="k1=v1,k2=v2"
kubectl run pod_name --image=image_name --port=80 --expose=true # Create a service directly
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Destroy pod

```bash
kubectl delete pod pod_name
```