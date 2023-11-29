---
title: "Drift"
date: 2023-11-09T18:41:58+01:00
draft: false
---

Drift is the difference between the state that is currently in the state file and the real infrastructure.

Drift can be caused by:
- manual changes to the infrastructure
- changes to the infrastructure that were not made with Terraform

## Managing drift

There is three ways to manage drift:

- Import the resource into the state file
- Refresh the state file
- Replace the resource

### Replace

The `-replace` flag in `apply` and `plan` commands allows to force the replacement of a resource given its address (e.g. `aws_instance.web`).

This is useful when a cloud resource is damaged and cannot be recovered.

### Refresh state

The `terraform refresh` command allows to update the state file with the current state of the infrastructure. It does not modify the infrastructure.

Its an alternative to `terraform apply -refresh-only` which does not require to have a configuration file. his is the correct way to do this since `refresh` has been deprecated.



### Import

The `terraform import` command allows to import an existing resource into the state file.

For this, a resource must be defined in the configuration file and the `terraform import` command must be run with the resource address as argument. This resource can have an empty body but it will not be automatically filled with the current state of the resource. 

The `import` command accepts a resource address as argument and the ID of the resource as second argument. What this id means depends on the provider. For example, for AWS, it is the ARN of the resource.

Example:

In the configuration file:

```hcl
resource "aws_instance" "web" {
  # ...
}
```
then run:

```bash
terraform import aws_instance.web i-1234567890abcdef0
```
