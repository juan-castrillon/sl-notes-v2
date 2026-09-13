---
title: "HPA"
date: 2026-09-13T17:02:30+02:00
draft: false
---

HPA stands for **Horizontal Pod Autoscaler** and its kubernetes built-in solution for scaling a replica set (adding more pods) based on resource consumption. 

## Process

{{% notice style="warning" title="Attention" %}}
HPA by default depends on the metrics server being available. As mentioned in the monitoring section, this is an extra step
{{% /notice %}}

![hpa](/images/K8s/k8s_hpa.png)

In here: 

- The hpa is aware of the limit declared by the deployment and is configured with a threshold
- Hpa monitors metrics servers periodically to check on resource consumption
- If it goes over the limit, it will add a pod
- When it goes down it will remove a pod

{{% notice style="note" title="Manually scaling" %}}
The same process could be done manually by observing the metrics and then scaling with `kubectl scale ...`
{{% /notice %}}

## Creation

{{% badge style="warning" title=" " %}}Imperative{{% /badge %}} 

```bash
$ kubectl autoscale deployment my-app --cpu-percent=50 --min=1 --max=10
```

As a yaml resource ,for example: 

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```