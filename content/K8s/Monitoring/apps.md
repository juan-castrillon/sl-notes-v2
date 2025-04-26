---
title: "Apps"
date: 2025-04-26T16:31:04+02:00
draft: false
---

## Access application logs

Using the `kubectl` tool, one can access container logs directly (similar to `docker logs`) :

```bash
kubectl logs pod
kubectl logs -f pod #Follow logs
kubectl logs pod container #For multi container pods
```

