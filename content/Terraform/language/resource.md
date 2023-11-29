---
title: "Resource"
date: 2023-11-06T18:25:47+01:00
draft: false
---

The resource block defines a resource that exists within the infrastructure. It is the most important block in Terraform.

This is a resource whose state is managed by terraform ,contrary to a data source which is read-only. This means this will be created, updated or deleted by terraform.

## Meta-Arguments

Meta-arguments are arguments that are available on every resource block. They are used to change the behavior of the resource.

### depends_on

- Explicitly specify the order of creation (or destruction) of resources.
- Used when Terraform cannot infer the correct order of creation (or destruction) of resources.
- Takes a list of resources that the current resource depends on.

Example:

```hcl
resource "aws_instance" "web" {
  # ...

  depends_on = [
    aws_db_instance.db,
  ]
}
```

### count

- Create multiple instances of a resource.
- Exposes a `count` variable that can be used in other arguments in the block. 
- It must be whole number and **known** during the planning phase. It can also be an expression. 

Example:

```hcl
resource "aws_instance" "web" {
  count = 2

  # ...

  tags = {
    Name = "web-${count.index}"
  }
}
```

### for_each

- Create multiple instances of a resource.
- Exposes a `each` variable that can be used in other arguments in the block.
- Input is either a map or a set.
- It must be known during the planning phase. It can also be an expression.

Example:

```hcl
resource "aws_instance" "web" {
  for_each = toset(["us-east-1", "us-west-1"])
  # ...
  tags = {
    Name = "web-${each.key}" # because is a set, each.key is the value
  }
}

resource "aws_instance" "db" {
  for_each = {
    us-east-1 = "db-east"
    us-west-1 = "db-west"
  }
  # ...
  tags = {
    Name = each.value
    Location = each.key
  }
}
```

### lifecycle

- Used to change the behavior of a resource during creation, update, and deletion.
- It can control actions like ignoring changes to a resource, preventing a resource from being destroyed, or creating multiple instances of a resource.

Example:

```hcl
resource "aws_instance" "web" {
  # ...

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
    create_before_destroy = true # if this is replaced, the new instance will be created before the old one is destroyed
  }
}
```

### provider

- Used to specify which provider a resource should use by using the alias of the provider.
- It can be used to override the default provider configuration.

Example:

```hcl
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "east"
  region = "us-east-1"
}

resource "aws_instance" "web" {
  # ...
  provider = aws.east  # use the provider with the alias "east"
}
```