---
title: "Provisioners"
date: 2023-10-30T19:03:20+01:00
draft: false
---

Provisioners are used to execute scripts on a local or remote machine as part of the resource creation or destruction process. (After the resource is created or destroyed)

General options are:

- cloud-init
- Packer 

> Should be avoided if possible. Terraform is not a configuration management tool. Provisioners do things that do not reflect in the state file. This can lead to inconsistencies between the state file and the actual infrastructure. Terraform recommends cloud-init where possible.

Terraform also has built in providers:

### local-exec

- Executes a command locally on the machine running terraform. 
- Used directly in the resource block.
- Has a required `command` argument which can receive terraform variables.
- Other arguments are:
  - working_dir
  - interpreter (shell)
  - environment (pass key value pairs to the command)

### remote-exec

- Executes a command on a remote machine via SSH or WinRM.
- Receives commands in 3 ways:
  - inline (list of commands as strings)
  - script (path to a script)
  - scripts (list of paths to scripts)
- - Requires a connection block to be defined in the resource block.

### file

- Used to copy files or directories to a remote machine via SSH or WinRM.
- Receives files in 2 ways:
  - content (string)
  - source (path to a file or directory)
- Requires a connection block to be defined in the resource block.


# Null Resource

- The null resource is a resource that does nothing. It allows the execution of provisioners outside of a resource block. This is useful for running provisioners that are not directly related to a resource or to run provisioners for blocks that have count set to more than 1.
- It has a `triggers` argument that can be used to trigger the execution of the provisioners. This can be used to trigger the execution of a provisioner when a variable changes. 
- Usage of the null provider can make a Terraform configuration harder to understand. While it can be useful in certain cases, it should be applied with care and other solutions preferred when available.
- One notable use case is to run a `wait` command to wait for the status of VMs to change.

# Terraform Data

- Similar to null resource but does not require any providers
- Recommended over null resource