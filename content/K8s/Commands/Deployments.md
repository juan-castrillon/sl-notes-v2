---
title: "Deployments"
date: 2025-04-12T14:27:41+02:00
draft: false
---

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Create Deployment

```bash
kubectl create deployment --image=img d_name
kubectl create deployment --image=img d_name --replicas=4 # Create with +1 replicas
```

#### Generate Deployment YAML file

```bash
kubectl create deployment --image=img --dry-run=client -o yaml
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Scale deployment

```bash
kubectl scale deployment d_name --replicas=4
```

#### See rollout status (following logs)

```bash
kubectl rollout status deployments/d_name
```

#### See revision history

```bash
kubectl rollout history deployments/d_name
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Rollback to previous revision

```bash
kubectl rollout undo deployments/d_name
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Change deployment image ad-hoc

```bash
kubectl set image deployments/d_name cont_name=image
```