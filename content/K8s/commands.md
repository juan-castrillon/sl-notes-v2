---
title: "Command Cheat Sheet"
date: 2024-10-12T16:42:53+02:00
draft: false
---

### Deployments

#### See rollout status (following logs)

```bash
kubectl rollout status deployments/d_name
```

#### See revision history

```bash
kubectl rollout history deployments/d_name
```

#### Rollback to previous revision

```bash
kubectl rollout undo deployments/d_name
```

#### Change deployment image ad-hoc

```bash
kubectl set image deployments/d_name cont_name=image
```

### General

#### Create resource from YAML

```bash
kubectl create -f res.yaml
kubectl apply -f res.yaml # Can be run in an existing resource without failing
```

#### Edit existing object definition in place

```bash
kubectl edit object_type object_name # Does not edit a YAML definition if there is one
kubectl replace -f res.yaml
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

### ReplicaSets

#### Get Replica Sets

```bash
kubectl get replicaset
kubectl get rs
```

#### Get single replica set

```bash
kubectl describe replicaset rs_name
```

#### Scale replica set ad-hoc

```bash
kubectl scale --replicas=6 replicaset rs_name
```

#### Destroy replica set

```bash
kubectl delete replicaset rs_name
```