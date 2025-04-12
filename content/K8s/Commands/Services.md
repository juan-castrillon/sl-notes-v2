---
title: "Services"
date: 2025-04-12T15:15:17+02:00
draft: false
---

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Create service for an existing pod

```bash
kubectl expose pod pod_name --port=port --name service_name # By default, ClusterIP
kubectl expose pod pod_name --port=port --target-port=tp --name service_name
kubectl expose pod pod_name --type=NodePort --port=port --name service_name # Port on node will be random, if this is not ok, it has to be done with a file
kubectl create service clusterip service_name --tcp=port:tp # Will not use the labels on a pod as selectors, but will search for labels app=service_name
```

#### Get service

```bash
kubectl get svc
```

#### Create service YAML File

```bash
kubectl expose pod pod_name --port=port --name service_name --dry-run=client -o yaml
kubectl create service clusterip service_name --tcp=port:tp  --dry-run=client -o yaml
```
