---
title: "Admission Controllers"
date: 2025-04-24T20:26:52+02:00
draft: false
---

Admission controllers are pieces of code that run inside the `kube-api-server` and process requests to modify (create, edit, etc) resources after they have been authenticated and authorized, but before they go to scheduling. 

They can be used both to verify configuration (Validating controllers) or take action (Mutating controllers). Some examples include:
- Deny a request that aims to create a pod in non-existent namespace (`NamespaceLifecycle` controller, type validating)
- If a request aims to create a pod in a non-existent namespace, first create the namespace (`NamespaceAutoProvision` controller, mutating type)

{{% notice style="tip" title="Order of execution" %}}
Mutating controllers always run first, so that their result can be validated.
{{% /notice %}}

By default, the `kube-api-server` includes a long list of [controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#what-does-each-admission-controller-do), although not all are enabled. They can be enabled/disabled using the configuration options in the `kube-api-server` service or container. 


## Enabling/Disabling Controllers

To enable controllers (or see which controllers are currently enabled), the option `--enable-admission-plugins` of the `kube-api-server` binary is used. In systems where this runs as a service, this can be checked in the service definition (using something like `systemctl cat`). In `kubeadm` systems, the server runs as a static pod, so the argument is passed in the pod definition present in the static pod path (See [static pods]({{< ref "k8s/scheduling/static" >}}))

Similarly, the option `--disable-admission-plugins` is used to disable the plugins.


## Custom controllers (Webhooks)

K8s provides two webhooks (controllers) (`MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook`) that allow to plug in custom controller implementations. 

The webhooks send a JSON request to a configured endpoint where the custom code listens. It then expects a standard response that uses to approve or deny the request like any other controller. 

Custom controllers are normally deployed as containers in the cluster (`Deployment` objects) with a `Service` object in front. Once they are up and listening, a `WebhookConfiguration` object is created to pass the service name to the admission controller. Below is an example:

```yaml
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: "pod-policy.example.com"
webhooks:
- name: "pod-policy.example.com"
  clientConfig:
    service:
      namespace: "webhook-namespace"
      name: "webhook-service" # Name of the deployed service
    caBundle: "Ci0tLS0tQk......tLS0K"
  rules: # What ype of requests use the custom webhook
  - apiGroups: [""]
    apiVersions: ["v1"]
    operations: ["CREATE"]
    resources: ["pods"]
    scope: "Namespaced"
```

Below, the image shows the complete admission process, including custom controllers:

![admission_control](/images/K8s/k8s_admission_control_phases.svg)