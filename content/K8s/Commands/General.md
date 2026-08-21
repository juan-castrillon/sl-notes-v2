---
title: "General"
date: 2025-04-12T13:27:59+02:00
draft: false
---

## Understanding resources and commands

`kubectl` also provides a way to self-document and facilitate working with the API resources. 

- If high level details about what resources are available (or their api version, etc.) are needed `kubectl api-resources` can be used. 
- To go into detail into one resource, and figure out what fields are available in a YAML definition and what they mean use `kubectl explain <resource>`
  - This allows to go down hierarchically (e.g `kubectl explain pod`, `kubectl explain pod.spec`)
  - Using the `--recursive` flag, prints all children


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

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Create resource from YAML

```bash
kubectl create -f res.yaml
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Replace resource from YAML

```bash
kubectl replace -f res.yaml
```

#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Delete resource from YAML

```bash
kubectl delete -f res.yaml
```


#### {{% badge style="warning" title=" " %}}Imperative{{% /badge %}} Edit existing object definition in place

```bash
kubectl edit object_type object_name # Does not edit a YAML definition if there is one
```