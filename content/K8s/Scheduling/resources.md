---
title: "Resource Limits"
date: 2025-04-24T10:25:14+02:00
draft: false
---

When scheduling, K8s takes into consideration available resources (CPU and Memory) at the nodes. However, by default, there is no upper limit, so eventually pods could "fill up" nodes. To prevent this, and to ensure certain resources at the container, pod or namespace level, the concept of request and limits is introduced. 

## Pod (Container) level

In each container in a pod, two thing can be defined to specify resource requirements and limits:

- `requests`: 
  - These act as requirements
  - They define the guaranteed amount of CPU and memory that a container will get
- `limits`
  - Define the maximum amount of CPU and memory that the container will get
  - In case of going over the CPU limit, the CPU available for the container will be throttled
  - If going over the memory limit, the container will be killed (OOM)

{{% notice style="tip" title="Units" %}}
CPU is specified in cores, which i typically equivalent to one vCPU in cloud environments like AWS, GCP, or Azure. In the definitions, fractional values can be be used with prefixes (e.g 100m is equal to 0.1). For memory, either bytes are used, either in base 1000 (K,M,G) or 1024 (Ki, Mi, Gi).
{{% /notice %}}

### Combination Behavior

| -           | No Limit                                                                                                                                                                                                                           | Limit Set                                                                                                                                                                                           |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No Request  | A container can use as much as it wants, potentially starving others in the same node                                                                                                                                              | K8s assumes an implicit `request` equal to the limits                                                                                                                                               |
| Request Set | Guarantees that containers will get their minumum resources needed, but they are free to use more. This is the recommended configuration for CPU, **NOT MEMORY**. [More info](https://home.robusta.dev/blog/stop-using-cpu-limits) | The container is guaranteed a certain amount but can peak and use up to the limit, however idle resources might be generated in the case of CPU (reserved but not utilized). Recommended for memory |


## Namespace level