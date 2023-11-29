---
title: "Terraform Block"
date: 2023-11-05T08:56:20+01:00
draft: true
---

The terraform block is normally the first block in a configuration. It is used to configure the behavior of Terraform itself.

Possible configuration options include:

- Required version of Terraform
- Required providers (the ones that will be downloaded when running `terraform init`)
- Backend configuration (where the state file will be stored)
- Experimental features