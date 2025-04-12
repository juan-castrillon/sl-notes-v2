---
title: "General"
date: 2025-04-12T13:27:59+02:00
draft: false
---

## Imperative vs Declarative management commands 

In K8s, there is three paradigms to manage general resources:

- **Imperative approach with commands**: Using `kubectl` commands like `run`, `create`, `edit`, `expose`, `scale` to perform operations
- **Imperative approach using a configuration file**: Using `kubectl` commands like `create`, `replace` and `delete` with `-f` options
- **Declarative approach using a configuration file**: Using `kubectl apply -f`

### `kubectl apply`

In general, due to best practices like maintainability, repeatability and documentation, the declarative approach (Using `kubectl apply` is preferred). This works based on 3 files:

- Input file
- Live object configuration file
- Last applied configuration (field in file above)

When deciding what to do, the program

1. Compares input configuration with last applied
2. Implement any changes in the live object configuration

> [!CAUTION]
> Because of the presence of the `last_applied_configuration` field in the LOCF, objects that were created and managed wit `apply` must not be changed to be managed with an imperative approach


## Imperative Commands

#### Create resource from YAML
{{% badge style="warning" title=" " %}}Imperative{{% /badge %}}
```bash
kubectl create -f res.yaml
```

#### Replace resource from YAML
{{% badge style="warning" title=" " %}}Imperative{{% /badge %}}
```bash
kubectl replace -f res.yaml
```

#### Delete resource from YAML
{{% badge style="warning" title=" " %}}Imperative{{% /badge %}}
```bash
kubectl delete -f res.yaml
```


#### Edit existing object definition in place
{{% badge style="warning" title=" " %}}Imperative{{% /badge %}}
```bash
kubectl edit object_type object_name # Does not edit a YAML definition if there is one
```