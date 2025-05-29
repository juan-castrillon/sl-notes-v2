---
title: "Commands and arguments"
date: 2025-05-29T16:31:53+02:00
draft: false
---

As most applications run as containers when deployed in a K8s cluster, one can define custom commands and arguments to run the container. 

In this sense, a parallel can be drawn to configuring a container in docker:

| In Docker    | In K8s config | What it does                                                                                                             |
| ------------ | ------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `CMD`        | `args`        | Command that will be executed when the container starts or alternatively arguments for the `ENTRYPOINT` of the container |
| `ENTRYPOINT` | `command`     | Specifies the command to run when the container starts (completely replacing Dockerfile `ENTRYPOINT`).                   |

For example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx 
spec:
  containers:
    - name: nginx-container
      image: nginx
      command:
        - sleep # Override default ENTRYPOINT
      args:
        - "5" # Pass 5 as the arg for sleep
```
