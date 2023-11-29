---
title: "Workspaces"
date: 2023-11-21T18:08:56+01:00
draft: false
---

Workspaces are used to managed multiple instances of the same infrastructure. They are useful for separating environments (dev, staging, prod) or for managing multiple instances of the same infrastructure (multiple Kubernetes clusters, multiple web apps, etc).

Workspaces are supported by the different backends (local, remote, and enhanced). In terraform cloud (remote backend) these don't map directly to workspaces in the UI. The "cloud" workspace is used for organization, similar to directories, and the "cli" workspace is used for environment management.

## default workspace

The default workspace is created automatically when running `terraform init`. It is used when no workspace is specified.

This workspace cannot be deleted.

## Interpolation

Workspaces can be used in interpolation expressions. The `terraform.workspace` variable can be used to get the name of the current workspace.

```hcl
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
  tags = {
    Name = "web-${terraform.workspace}"
  }
}
```

## CLI Commands

- `terraform workspace list`: Lists all workspaces
- `terraform workspace new <name>`: Creates and switch to new workspace
- `terraform workspace select <name>`: Selects a workspace
- `terraform workspace show`: Shows the current workspace
- `terraform workspace delete <name>`: Deletes a workspace


## Mapping to Terraform Cloud

Terraform Cloud supports multiple workspaces per project. Depending on the configuration used, those environments can be automatically mapped to CLI workspaces.

### Legacy remote backend

If using terraform cloud with the legacy remote backend code block, the `prefix` attribute can be used to map workspaces to CLI workspaces.

```hcl
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "TestJPOrg"

    workspaces {
      prefix = "cli-"
    }
  }
}
```

The example above will use all workspaces that start with `cli-` as CLI workspaces. They will be shown when running `terraform workspace list` and can be selected with `terraform workspace select <name>`.

### Cloud block

If using the cloud block, the `tags` or `project` attribute can be used to map workspaces to CLI workspaces.

```hcl
terraform {
  cloud {
    organization = "TestJPOrg"
    workspaces {
      tags = ["cli"]
    }
  }
}
```

The example above will use all workspaces that have the `cli` tag as CLI workspaces. They will be shown when running `terraform workspace list` and can be selected with `terraform workspace select <name>`. Similarly, the `project` attribute can be used to map all workspaces in a project to CLI workspaces.