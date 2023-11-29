---
title: "Commands"
date: 2023-10-28T11:45:34+02:00
draft: false
---

## init
- downloads the provider plugins and modules and initializes the backend
- stores them in the .terraform folder
- creates a dependency lock file to enforce the same versions of the providers and modules (`.terraform.lock.hcl`)
- with the `-upgrade` flag, it will upgrade the providers and modules to the latest version that matches the version constraints in the configuration

## get

- downloads only modules and stores them in the `.terraform` folder

## validate
- validates the syntax of the terraform files
- checks for required variables and provider configuration
- does not check for correctness of the code (e.g. if a resource exists)

## fmt
- formats the terraform files
- with the `--diff` flag, it will show the changes that will be made

## console

- opens an interactive console to test expressions

## plan
- creates an execution plan that shows what will be done when apply is called
- shows what resources will be created, modified or destroyed
- shows the order of operations
- the `-out` flag can be used to save the plan to a file that can be used with `apply` to apply the plan

## show

- Reads and outputs a Terraform state or plan file in a human-readable form
- If no path is specified, the current state will be shown.

## apply
- creates, modifies or destroys resources
- creates a state file that contains the current state of the infrastructure (local or remote)

## destroy
- destroys all resources that are defined in the configuration
- does not remove the state file