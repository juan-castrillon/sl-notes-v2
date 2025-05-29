---
title: "Environment Variables"
date: 2025-05-29T16:53:54+02:00
draft: false
---

As most applications tend to follow the [12 factor config](https://12factor.net/config) standard, setting environment variables becomes important to configure the applications. In K8s,there is 3 ways of setting them

## Environment Variables in pod spec

As part of the pod definition, one can set environment variables that will be made available inside the container (similar to using the `-e` flag in docker):

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 80
      env:
        - name: APP_COLOR
          value: blue
        - name: APP_MODE
          value: prod
```

## ConfigMap

[ConfigMap]({{< ref "k8s/api_objects" >}}) objects can be mounted as environment variables for containers. There are two options:

1. Import all values from the `ConfigMap`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 80
      envFrom:
        - configMapRef:
            name: myconfigmap
```


2. Import certain values

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 80
      env:
        - name: APP_COLOR
          valueFrom:
            configMapRef:
                name: myconfigmap
                key: color
```


## Secrets

[Secret]({{< ref "k8s/api_objects" >}}) objects can be mounted as environment variables for containers. There are two options:

1. Import all values from the `Secret`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 80
      envFrom:
        - secretRef:
            name: mysecret
```


2. Import certain values

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 80
      env:
        - name: APP_COLOR
          valueFrom:
            secretKeyRef:
                name: my-secret
                key: color
```