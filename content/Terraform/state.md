---
title: "State"
date: 2023-11-09T18:12:45+01:00
draft: false
---

Terraform stores the state of the infrastructure it manages in a file. This state file is extremely important; it maps various resource metadata to actual cloud resource IDs so that Terraform knows what it is managing. 

Terraform uses this local state to create plans and make changes to your infrastructure. 

Local state is stored in a file named `terraform.tfstate`.

## State File

- The state file is a JSON file that contains the following information:
  - Resource IDs
  - Resource metadata
  - Resource attributes
  - Output values
  - Provisioners
  - Module dependencies
  - etc.

- The state file contains sensitive information like passwords, keys, etc. in plain text and special care must be taken to protect it.
- Terraform cloud takes measures to protect the state file like encrypting it at rest and in transit, storing it on memory, etc.

## CLI Commands

- `terraform state list`: Lists all resources in the state file.
- `terraform state show <resource>`: Shows the attributes of a specific resource in the state file.
- `terraform state rm <resource>`: Removes a resource from the state file (not destroyed).
- `terraform state mv <resource> <new-resource>`: Moves a resource in the state file.
  - Allows for renaming resources avoiding destroying and recreating them.
- `terraform state pull`: Pulls the state and outputs it as JSON.
- `terraform state push`: Pushes a local state file to remote state.

## Backups

- Terraform commands that modify state will automatically create backups of the prior state in a file called `terraform.tfstate.backup`.


## Backends

Each Terraform project has a backend that defines where and how operations are performed, where state snapshots are stored, etc.

There is two types of backends:

- Standard: Can only store state but not perform any terraform operations.
  - Third party providers (normally storage providers).
    - S3, Azure Blob Storage, Google Cloud Storage, etc.
    - Others like: Consul, etcd, http, postgresql, etc.
- Enhanced: Can store state and perform terraform operations.
  - Local: Stores state locally in a file and performs operations locally.
  - Remote: Stores state remotely and performs operations remotely.

The `-backend-config` flag can be used with `terraform init` to specify backend configuration values without having to modify the configuration file. This is useful for storing secrets like access keys and passwords in backends like S3 or http.


### Local Backend

- The local backend stores state locally in a file named `terraform.tfstate`.
- Used by default if no backend is specified.
- Path of the state file can be changed with the configuration block

### Remote Backend

- Remote backends store state remotely and perform operations remotely (Terraform cloud, terraform enterprise )
- Uses the concept of workspaces to store state for different environments.
  - Workspaces are like different instances of the same infrastructure.
  - Each workspace has its own state file.
  - Workspaces can be used to separate environments (dev, staging, prod) or different components of the same infrastructure (networking, compute, storage, etc.).
  - When configuring a remote backend, a workspace name or a prefix (if using multiple workspaces) must be specified.

It can be configured with a `backend` block:

```hcl
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "TestJPOrg"

    workspaces {
      name = "test-wp"
    }
  }
}
```

But its recommeded to use a `cloud` block instead:

```hcl
terraform {
  cloud {
    organization = "TestJPOrg"
    workspaces {
      name = "test-wp"
    }
  }
}
```

### `terraform_remote_state` Data Source

- The `terraform_remote_state` data source can be used to access the state of a different Terraform project.
- It exposes the outputs of the root module of the target project.
- Its argument `backend` can be used to specify a remote or local backend target

Example:

```hcl
data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.subnet_id
}
```

> In general is recommended to use normal data sources instead of `terraform_remote_state`. This is because access to the entire state is required to use `terraform_remote_state` and this can lead to unintended consequences and security issues. Using normal data sources also provides interaction with live data instead of the data in the state file.

## State Locking

- Terraform uses a state lock to prevent two processes from modifying the state at the same time.
- It acts similarly to a mutex.
- It happens automatically when running any command that modifies state.
- In case the automatic lock fails, Terraform will show an error with the lock ID and the user can manually unlock the state with `terraform force-unlock <lock-id>`. **This should only be used as a last resort**.