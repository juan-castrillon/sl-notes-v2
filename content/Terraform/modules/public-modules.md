---
title: "Public Modules"
date: 2023-11-10T18:37:51+01:00
draft: false
---

Terraform modules can be published on the [Terraform Registry](https://registry.terraform.io/). This is the official registry of Terraform modules.

Modules can be of three types:

- Official modules: published by HashiCorp
- Verified modules: published by a verified publisher
- Community modules: published by anyone

> When using the search bar on the Terraform registry only verified and official modules are shown by default.

## Using modules

To use a module, add a `module` block to the configuration file:

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.9.0"
  # ...
}
```

`terraform init` will download the module and its dependencies.

## Publishing modules

- The terraform registry is a public index of modules
- To publish a module, it has to be published to a git repository (mainly GitHub) following a specific structure for the naming of the repository and the files
- When working with github, the account can be integrated with the terraform registry to automatically publish modules when a new release is created.