---
title: "Storage"
draft: false
---

Kubernetes (K8s) manages containerized applications, but the pods it runs are temporary by design. When a pod stops or moves, any data stored inside its containers is lost. To keep data beyond the lifecycle of a pod, Kubernetes uses a system of volumes and storage resources designed for persistence and flexibility.


## CSI (Container Storage interface)

At the heart of Kubernetes storage is the **Container Storage Interface (CSI)**, which standardizes how Kubernetes talks to storage providers. Instead of hardcoding support for specific storage types, Kubernetes uses CSI as a plugin system. This interface defines a set of remote procedure calls (RPCs) that storage providers implement, allowing Kubernetes to create, delete, attach, and manage volumes dynamically across many different storage backends.


## Volumes and Pods

Since pods are transient, data stored inside containers is temporary unless a volume is attached. A **volume** is a directory, possibly backed by physical storage, that Kubernetes mounts into containers, preserving data beyond container restarts.

Creating a volume in Kubernetes involves two steps: defining the volume and mounting it inside the container. A simple example of a volume definition using a local path looks like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: app-container
    image: busybox
    volumeMounts:
    - name: local-storage
      mountPath: /data
  volumes:
  - name: local-storage
    hostPath:
      path: /mnt/data
```
{{% notice style="warning" title="Production clusters" %}}
`hostPath` volumes tie storage to a specific node’s local filesystem, which limits portability and is generally unsuitable for production clusters where pods may be scheduled on different nodes. Other options (like nfs volumes) exist.
{{% /notice %}}

## Persistent Volumes and Claims

Managing storage directly inside pod definitions is cumbersome. Kubernetes introduces Persistent Volumes (PV) as cluster-wide resources representing real storage, whether cloud-based, network-attached, or local disks. Rather than pods creating their own volumes, they request storage through Persistent Volume Claims (PVC).

A PV might look like this:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/data
```

The `accessModes` specify how the volume can be mounted:

- `ReadWriteOnce` allows read-write by a single node.
- `ReadOnlyMany` allows read-only by multiple nodes.
- `ReadWriteMany` allows read-write by multiple nodes.

Pods then request storage by creating a PVC, which is then matched to a suitable PV. A PVC example:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-example
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

The PVC specifies the amount of storage needed and access mode, and Kubernetes binds it to a PV that satisfies those requirements.


### Lifecycle and Reclaim Policy

When a PVC is deleted, what happens to the underlying storage depends on the PV’s `persistentVolumeReclaimPolicy`:

- `Retain` (default): The PV and its data remain but the volume is not available for reuse until manually cleaned.
- `Delete`: The PV and its storage are deleted automatically.
- `Recycle`: The volume’s data is wiped and the volume becomes available for new claims.



## Storage classes

Volumes (PVs) are normally created manually by administrators before pods use them. Kubernetes supports Storage Classes to automate this through dynamic provisioning. A `StorageClass` defines how to provision storage dynamically from a backend storage system.

When a PVC includes a `spec.storageClassName`, Kubernetes uses the associated Storage Class’s provisioner to automatically create a PV that meets the PVC’s requirements, bind it, and make it available to the pod.

`StorageClass` objects can be created to connect to a number of storage provisioners:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: google-storage
provisioner: kubernetes.io/gce-pd
```
