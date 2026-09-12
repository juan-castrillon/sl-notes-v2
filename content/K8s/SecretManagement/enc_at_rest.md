---
title: "Encryption at Rest"
date: 2026-09-12T11:08:59+02:00
draft: false
---

When dealing with Kubernetes secrets, the values are not only stored in the definitions used to create the resources. Critically, they are also stored in the etcd store that the cluster uses for configuration. 

By default, secret values in this store can just be read directly which is a vulnerability. 

K8s offers a process to encrypt these values: https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/

THis process involves:
- Creating an `EncryptionConfiguration` object
  - In here it can be determined:
    - WHich resources to encrypt at rest (e.g secrets, but also others)
    - Which provider to use for encryption  (algorithm) which receive encryption keys
- Passing it to the kube-api-server process as a parameter

{{% notice style="warning" %}}
Secrets created before enabling encryption will **not** be encrypted. This will only happen if the secret definition is somehow changed/updated. This can be triggered with something like 
```bash
kubectl get secrets --all-namespaces -o json | kubectl replace -f -
```
{{% /notice %}}