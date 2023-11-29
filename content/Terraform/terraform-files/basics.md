---
title: "Basics"
date: 2023-10-28T11:47:46+02:00
draft: false
---

# providers
- terraform providers are responsible for understanding API interactions and exposing resources
- they are configured within the terraform block (version) and the provider block (specific provider configuration)


# input variables

- variables are used to parameterize terraform configurations
- they can be read from different sources:
  - command line flags
  - environment variables
  - files (e.g. tfvars)

# locals

- locals are variables that are only used within the configuration
- they are not exposed to the outside world

# outputs

- outputs are used to expose information about the infrastructure
- they can be read from the state file
- they can be used as input for other configurations