---
title: "Backup"
date: 2026-10-01T15:00:06+02:00
draft: false
---


There a several options to backup the running configuration and workload of a cluster. Some are listed below:

## Declarative Resources in Git

The simplest way of backing up configurations is making sure to always deploy everything via declarative approach (YAML files) and storing these files in version control (e.g github).

This is a way to ensure that even on complete cluster failure, all workloads can be restored with the exact same config as before. 

## Using the api

Some objects can be created outside YAML files (e.g operators doing it imperatively, resources created by operators, etc). For this cases, a naive solution would be to use the API to read the resources and backing them up:

```bash
kubectl get pods --all-namespaces -o yaml > all_pods.yaml
```

Tools like [velero](https://velero.io/) take this approach and make it robust, using API calls to back up all resources

## etcd Backup

Another option is to directly backup the cluster's backend by creating a backup of the `etcd` cluster. 

```bash
ETCDCTL_API=3 etcdctl snapshot save snapshot.db
ETCDCTL_API=3 etcdctl snapshot status snapshot.db
```

This backup can be easily restored (using a different data directory)

```bash
ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
--data-dir /var/lib/etcd-from-backup
```

The `etcd` service can then be modified and restarted

{{% notice style="note" title="" %}}
Before restoring, is necessary to bring the kube api-server down. It can be brought back up once the new etcd is running
{{% /notice %}}

