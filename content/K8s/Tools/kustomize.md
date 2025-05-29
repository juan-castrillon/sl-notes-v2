---
title: "Kustomize"
date: 2025-05-29T17:52:39+02:00
draft: false
---

[Kustomize](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/) is a tool that allows for managing and customizing Kubernetes resource configuration files. 

It is an extra layer that allows to simplify configuration by avoiding repeating code, and using the concepts of base and overlays to generate custom configurations while leaving the original YAML untouched and usable as is.


## Usage

Kustomize works by defining a `kustomization.yaml` file. This file defines mainly two things:

- Which resources (k8 configs) should be managed by kustomize
- Which customizations need to be made

Once this is defined, one can call

```bash
kustomize build dir/ 
```

Which will print the modified configurations. This can be piped to apply in the cluster directly

```bash
kustomize build dir/ | kubectl apply -f -
```

> Alternatively, `kubectl` ships with kustomize built in (normally older version), and can be called with `kubectl apply -k dir/` to call customize and then deploy the result

## Directory Structure

Kustomize can be used in many different ways. It can be used to manage a single folder of resources (e.g adding a common tag to all resources)

```tree
- dir | folder
  - kustomization.yaml | file-alt | red
  - deployment.yaml | file-alt | blue
  - service.yaml | file-alt | blue
```

In here the `kustomization` file will look like:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
  - service.yaml
# Customizations to be applied
```

For more real scenarios, configuration can be split into directories, with the root `kustomization.yaml` including each directory. 

```tree
- dir | folder
  - kustomization.yaml | file-alt | red
  - api | folder
    - kustomization.yaml | file-alt | red
    - deployment.yaml | file-alt | blue
    - service.yaml | file-alt | blue
  - db | folder
    - kustomization.yaml | file-alt | red
    - deployment.yaml | file-alt | blue
    - service.yaml | file-alt | blue
```

In here the root `kustomization` file will look like below, and the directory ones, like the one above:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - api/
  - db/
# Customizations to be applied
```

Finally, Kustomize provides an organized ways of dealing with different enviroments with a base-overlays setup:

```tree
- base | folder
  - kustomization.yaml | file-alt | red
  - api | folder
    - kustomization.yaml | file-alt | red
    - deployment.yaml | file-alt | blue
    - service.yaml | file-alt | blue
  - db | folder
    - kustomization.yaml | file-alt | red
    - deployment.yaml | file-alt | blue
    - service.yaml | file-alt | blue
- overlay | folder
    - dev | folder
        - kustomization.yaml | file-alt | red
        - api | folder
            - kustomization.yaml | file-alt | red
            - deployment.yaml | file-alt | blue
            - service.yaml | file-alt | blue
        - db | folder
            - kustomization.yaml | file-alt | red
            - deployment.yaml | file-alt | blue
            - service.yaml | file-alt | blue
    - prod | folder
        - kustomization.yaml | file-alt | red
        - api | folder
            - kustomization.yaml | file-alt | red
            - deployment.yaml | file-alt | blue
            - service.yaml | file-alt | blue
        - db | folder
            - kustomization.yaml | file-alt | red
            - deployment.yaml | file-alt | blue
            - service.yaml | file-alt | blue
```

In here the `kustomization` files will look like:

**base/kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - api/
  - db/
```

**prod(dev)/kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../base/
  - api/
  - db/
# Customizations to be applied
```

## Customizing configurations

### Transformers

Transformers allow modification of all resources. These include things like: 

- Attach labels
- Add annotations
- Add name prefix/suffix
- Add a namespace

These actions are done with **common** transformers:

```yaml
commonLabels:
  org: example # All resources under this k.yaml will have this label
commonAnnotations:
  branch: master # All resources under this k.yaml will have this annotation
namePrefix: pre- # All resources under this k.yaml will have the name pre-<name>
nameSuffix: -dev # All resources under this k.yaml will have the name <name>-dev
namespace: lab  # All resources under this k.yaml will have the namespace defined
```

Similarly, `images` transformers can be used to modify container images in all resources (that have one). Either the complete image can be replaced:

```yaml
images:
  - name: nginx
    newName: haproxy
    newTag: 2.4
```

or just the tag

```yaml
images:
  - name: nginx
    newTag: 2.4
```

### Patches

Patches also allow for customization, but enable a more "surgical" approach than transformers. This means that certain (not all) resources can be targeted. 

Patches can be defined in-line or as separate files. They can also be specified either in:
- [JSON 6902 format](https://datatracker.ietf.org/doc/html/rfc6902), defined by three values: Operation, Target (The patch target selects resources by group, version, kind, name, namespace, labelSelector and annotationSelector. ), Value (except if operation is remove)
- Using [SMP](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#patchstrategicmerge) (Strategic Merge Patch): Uses K8s configurations, which copy the target but only shows the fields that need change. 

> I find JSON6902 easier to read, so all my examples will be using that format

Available operations are:

```yaml
# add: creates a new entry with a given value
- op: add
  path: /some/new/path
  value: value
# replace: replaces the value of the node with the new specified value
- op: replace
  path: /some/existing/path
  value: new value
# copy: copies the value specified in from to the destination path
- op: copy
  from: /some/existing/path
  path: /some/path
# move: moves the node specified in from to the destination path
- op: move
  from: /some/existing/path
  path: /some/existing/destination/path
# remove: delete's the node('s subtree)
- op: remove
  path: /some/path
# test: check if the specified node has the specified value, if the value differs it will throw an error
- op: test
  path: /some/path
  value: "my-node-value"
```

#### Examples

<table>
<tr>
<td>Use case</td> <td>Resource</td> <td>kustomization.yaml</td> <td>Result</td>
</tr>
<tr>
<td>Changing a value in a dictionary</td>
<td>

```yaml  
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    hello: oe
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
``` 
</td>
<td>

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
patches:
    - target:
        kind: Pod
        name: simple-webapp-color
      # Instead of inline, path can be used to point to a patch file
      patch: |-
        - op: add
          path: /metadata/labels/goodbye
          value: bye
    - target:
        kind: Pod
        name: simple-webapp-color
      # Instead of inline, path can be used to point to a patch file
      patch: |-
        - op: replace
          path: /metadata/labels/hello
          value: hi
```
</td>
<td>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    hello: hi
    goodbye: bye
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
```
</td>
</tr>
<tr>
<td>Changing a value in a list</td>
<td>

```yaml  
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
    - name: logger
      image: logger
``` 
</td>
<td>

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
patches:
    - target:
        kind: Pod
        name: simple-webapp-color
      patch: |-
        - op: remove
          path: /spec/containers/1
    - target:
        kind: Pod
        name: simple-webapp-color
      patch: |-
        - op: replace
          path: /spec/containers/0/image
          value: redis
    - target:
        kind: Pod
        name: simple-webapp-color
      # /- appends to the list
      patch: |-
        - op: add
          path: /spec/containers/- 
          value:
            name: lb
            image: nginx
```
</td>
<td>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: redis
    - name: lb
      image: nginx
```
</td>
</tr>
</table>


## Components

Kustomize enables the use of "reusable" blocks of configuration (resources + patches) to avoid copying code even further. These blocks are called components. 

They are very useful for customizations that only certain overlays should have, and that can be turned on on demand (e.g features). 

For example:

![](/static/images/K8s/k8s_kustomize_components_1.jpg)

For this an extra folder is created:


```tree
- k8s/ | folder
    - base/ | folder
        - kustomization.yaml | file-alt | red
        - api-depl.yaml | file-alt | blue
    - components/ | folder
        - caching/ | folder
            - kustomization.yaml | file-alt | red
            - deployment-patch.yaml | file-alt | green
            - redis-depl.yaml | file-alt | blue
        - db/ | folder
            - kustomization.yaml | file-alt | red
            - deployment-patch.yaml | file-alt | green
            - postgres-depl.yaml | file-alt | blue
    - overlays/ | folder
        - dev/ | folder
            - kustomization.yaml | file-alt | red
        - premium/ | folder
            - kustomization.yaml | file-alt | red
        - standalone/ | folder
            - kustomization.yaml | file-alt | red
```

{{% notice style="warning" %}}
Component `kustomization.yaml` files define `Component` objects instead of `Kustomization`. These objects have no `resources`. More info [here](https://kubectl.docs.kubernetes.io/guides/config_management/components/)
{{% /notice %}}

As the necessary deployments and patches are defined in `components`, the environment files can just call the components to include them:

**overlays/premium/kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base/
components:
  - ../../components/
# Other Customizations to be applied
```