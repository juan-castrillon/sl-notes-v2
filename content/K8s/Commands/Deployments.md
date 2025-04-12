---
title: "Deployments"
date: 2025-04-12T14:27:41+02:00
draft: false
---

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