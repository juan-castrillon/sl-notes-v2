---
title: "VPA"
date: 2026-09-13T17:49:54+02:00
draft: false
---

VPA stands for **Vertical pod autoscaler** and is a solution to adjust pod resource requests and limits automatically to optimally use the infrastructure

{{% notice style="info" title="" %}}
VPA needs to be installed on top of the cluster as it does not come by default. This can be done by installing:
- CRDs
- RBAC resources
- Deployments (one per component)

pulling them from the official [repo](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler).
{{% /notice %}}

## Process

![vpa](/images/K8s/vpa-architecture.svg)

In here: 
- The recommender evaluates current and historical usage and creates a recommendation
- The updater then identifies pods that do not comply with the recommendation (have too much, too little) and evicts them
- This causes the deployment/statefulset/replicaset to create a new pod,which is injected the recommended values by the Admission Controller

{{% notice style="warning" title="Attention" %}}
VPA by default depends on the metrics server being available. As mentioned in the monitoring section, this is an extra step
{{% /notice %}}

The Recommender analyzes both current and historical resource usage data (CPU and memory) for each Pod targeted by the VerticalPodAutoscaler. It examines:

- Historical consumption patterns over time to identify trends
- Peak usage and variance to ensure sufficient headroom
- Out-of-memory (OOM) events and other resource-related incidents

Based on this analysis, the Recommender calculates three types of recommendations:

- Target recommendation (optimal resources for typical usage)
- Lower bound (minimum viable resources)
- Upper bound (maximum reasonable resources).

Given that it uses historical data, small peaks and aberrations tend to not be that influential. It will also never evict the last pod of an application to avoid downtime, so a minimum of 2 pods are required (for Recreate mode)

## Creation

```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: my-app-vpa
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: my-app
  updatePolicy:
    updateMode: "Recreate"
  resourcePolicy:
    containerPolicies:
    - containerName: "application"
      minAllowed:
        cpu: 100m
        memory: 128Mi
      maxAllowed:
        cpu: 2
        memory: 2Gi
      controlledResources:
      - cpu
      - memory
      controlledValues: RequestsAndLimits
```

### Modes

The resource supports different modes of operation (`updatePolicy.updateMode`):
- `Off`: Only the recommender works, so no action is taken but recommendations can be seen
- `Initial`: Recommendation will only be applied in new created nodes, but existing ones will be left alone
- `Recreate`: Actively manage pods by evicting and recreating non compliant pods
- `InPlace` and `InPlaceOrRecreate` will use k8s new [feature](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/) (beta) to modify the resources but not evicting the pods

### Resource policies

One can also control how the VPA behaves with resource policies:

- `minAllowed` and `maxAllowed` give limits to the recommendations 
- `controlledResources` defined which (cpu or memory or both) resources are controlled by the VPA (by default both)
- `controlledValues` determines whether VPA controls resource requests, limits, or both (default).


