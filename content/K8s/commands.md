---
title: "Command Cheat Sheet"
date: 2024-10-12T16:42:53+02:00
draft: false
---

### General

#### Create resource from YAML

```bash
kubectl create -f res.yaml
kubectl apply -f res.yaml # Can be run in an existing resource without failing
```

### Pods

#### Run pod ad-hoc

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

#### Destroy pod

```bash
kubectl delete pod pod_name
```

