---
title: "Providers"
date: 2023-11-01T08:56:20+01:00
draft: false
---

Providers are used to interact with the APIs of various platforms. They are used to create, update and delete resources.

Some include:
- Cloud providers (AWS, Azure, GCP)
- Databases (MySQL, PostgreSQL)
- SaaS Platforms (GitHub, Datadog, PagerDuty)

They are separate plugins and are downloaded when running `terraform init`

TO get an overview of the providers used by a module, run `terraform providers`

# Tier

They are divided into three tiers:
- Official: maintained by HashiCorp
- Verified: maintained by a partner of HashiCorp
- Community: maintained by the community (no guarantee of maintenance)

# Registry

The Terraform Registry is a public index of providers and modules. It is used to discover providers and modules and download them.

# Configuration Block

- The configuration block is used to configure the provider. It is defined at the root of the configuration.
- Its different for each provider

## Aliases

- Aliases are used to configure multiple instances of the same provider (for example, multiple AWS accounts, or different regions)
- They are created by adding an `alias` argument to the provider block:

```hcl
provider "aws" {
  alias = "west"
  region = "us-west-2"
}
```

- They can be used in the resource level, module level or parent provider level:

```hcl
resource "aws_instance" "example" {
  provider = aws.west
  # ...
}
```
```hcl
module "vpc" {
  source = "./vpc"
  providers = {
    aws = aws.west
  }
}
```
```hcl
terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
        configuration_aliases = [ aws.west ]
        }
    }
}
```

This last declaration specifies that when another module calls this one it must explicitly provide a provider configuration named aws.west, rather than just inheriting a default AWS provider configuration automatically.