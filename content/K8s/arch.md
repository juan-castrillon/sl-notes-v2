---
title: "Architecture"
date: 2025-04-11T19:26:12+02:00
draft: false
---

## Cluster Architecture

In kubernetes, different machines organize in a **cluster**. A Kubernetes cluster consists of a control plane (master node) plus a set of worker machines, called nodes, that run containerized applications. Every cluster needs at least one worker node in order to work. 

- **Nodes**: This machines run the actual workloads. They have a container runtime that allows to run containers in them. 
- **Master**: This machines manage the cluster, store information about its workers and monitors them. They are in charge of receiving the workloads and dividing them in the workers, as well as all parts of orchestration (moving the load, replication, etc.)

![arch](/images/K8s/kubernetes-cluster-architecture.svg)

## Components

K8s is composed of the following components, that reside in either master or node machines:

### Master nodes

#### **API Server**

Provides a single interface that allows to control the cluster. CLIs, tools, UIs and users use this to interact with the cluster (like `kubectl`). 

This component sits in the middle of all cluster actions that add, remove or edit something. In this way, a request to create a pod has the following process:

1. The API server authenticates and validates the request.
2. It Constructs a pod object (initially without a node assignment) and updates the `etcd` store.
3. Notifies the requester that the pod has been created.
4. The scheduler continuously monitors the API Server for pods that need node assignments. Once a new pod is detected, the scheduler selects an appropriate node and informs the API Server. 
5. The API Server then updates the `etcd` datastore with the new assignment
6. It passes this information to the `kubelet` on the worker node. The `kubelet` deploys the pod via the container runtime and later updates the pod status back to the API Server for synchronization with etcd.

It handles:
- Authentication & Validation of requests
- Interaction with `etcd` (In fact is the only component that access it)
- Communication with `kube-scheduler` and `kubelet`

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it. K8s installations from `kubeadm`, install it as a pod in the `kube-system` namespace.


#### **etcd**

Distributed Key value store that is used to store cluster information. 

> To interact with an installation of `etcd`, the `etcdctl` CLI is used. For example `etcdctl set k1 v1`, or `etcdctl put k1 v1` in v3.

In K8s, `etcd` is used to store cluster information that includes configuration data, state and metadata. As a rule of thumb, most `kubectl get` commands, read information from `etcd`. Most actions on the cluster, first are implemented, then registered into `etcd` and just then are deemed done. Normally, data is stored under the `registry` parent key, following a folder structure (e.g `registry/pods/...`).

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it, including details about clustering. K8s installations from `kubeadm`, install it as a pod in the `kube-system` namespace.

#### **Scheduler**

Component that distributes the work in the different nodes deciding **but does not placing** the pods in the worker nodes. It takes different factors like resource usage, constraints, among others into consideration. It does this by:

1. Filtering out nodes
2. Ranking possible nodes and choosing the best

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it, including details about clustering. K8s installations from `kubeadm`, install it as a pod in the `kube-system` namespace.

#### **Controller Manager**

Brains of the operation. Is in charge of controllers (processes) which monitor containers/nodes and act accordingly to always have a desired state (Similar to a PID controller). Some of the controller include `NodeController`, `ReplicaSets`, etc.

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it, including details about clustering. K8s installations from `kubeadm`, install it as a pod in the `kube-system` namespace.

### Worker nodes

#### **Container runtime**

Software used to run containers. Traditionally used `docker`, but recently supports only those who implement the [CRI](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-node/container-runtime-interface.md) interface. These include `containerd`, `cri-o` among others.

#### **kubelet**

Agent that runs in all nodes and interacts with the api-server in the masters. It manages and monitors the containers and the nodes. IT also interacts with the container runtime to provision the pods.

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it, including details about clustering. 

> Opposite to other components, K8s installations from `kubeadm` **do not** install `kubelet` in the nodes. It has to be manual.

#### **kube-proxy**

Lightweight process that runs on every node. Its key function is to monitor for `Service` creations and configure network rules that redirect traffic to the corresponding pods. One common method it uses is by setting up `iptables` rules.

It is installed as a single binary, and normally deployed as a service in the master machines. In here, in the `ExecStart` field, many arguments can be passed to configure it, including details about clustering. K8s installations from `kubeadm`, install it as a `DaemonSet`, ensuring it runs in each node.