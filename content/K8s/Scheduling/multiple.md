---
title: "Multiple Scheduler and Profiles"
date: 2025-04-24T12:08:05+02:00
draft: false
---

## Multiple schedulers

If a different scheduling algorithm, or more particular requirements are needed, a custom scheduler can be deployed. Moreover, once can even run multiple schedulers simultaneously alongside the default scheduler and instruct Kubernetes what scheduler to use for each of the pods.

Following good practices, the scheduler can be packaged and distributed as a binary (to create a service) or a container (to create a K8s deployment). 

Once deployed, pods can choose which scheduler to use, for example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
      image: nginx
  schedulerName: my-custom-scheduler
```

THe process of deploying a custom scheduler is shown [here](https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/)


## Scheduling profiles

As a more lightweight alternative to multiple schedulers, K8s (Starting in 1.18) now supports the definitions of different profiles using the same scheduler binary. 

This approach minimizes operational overhead and prevents potential race conditions that can arise when multiple processes schedule workloads on the same node.

It works by allowing profile definitions in the scheduler configuration definition. These profiles can then manipulate (add or disable) [scheduling plugins]({{< ref "k8s/scheduling/process" >}}) thus defining different behaviors from one another. Here is an example definition file:

```yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: my-scheduler-2
    plugins:
      score:
        disabled:
          - name: TaintToleration
        enabled:
          - name: MyCustomPluginA
  - schedulerName: my-scheduler-3
    plugins:
      preScore:
        disabled:
          - name: '*'
      score:
        disabled:
          - name: '*'
  - schedulerName: my-scheduler-4
```

{{% notice style="tip" %}}
This file is normally mounted as `ConfigMap` in the scheduler pod or as an argument for the binary (in case of a service)
{{% /notice %}}

Pods can then specify the scheduler they use in their definition files as above. 