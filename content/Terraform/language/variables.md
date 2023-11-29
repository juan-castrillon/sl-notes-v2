---
title: "Variables"
date: 2023-11-05T08:56:20+01:00
draft: false
---

# Input Variables

Input variables are used to parameterize Terraform configurations. They are defined in the root module or a child module.

They are defined using the `variable` block and normally stored in a different file (e.g. `variables.tf`).

Each block allows for different arguments:

- `type`: the type of the variable (string, number, bool, list, map, object, tuple, set, any)
- `default`: the default value of the variable
- `description`: a description of the variable
- `validation`: a validation rule(s) for the variable
- `sensitive`: whether the variable is sensitive (will not be shown in the output)

Example:

```hcl
variable "region" {
  type        = string
  description = "The region where the resources will be created"
  default     = "us-east-1"
}
```

## Variable Definitions

Variables can be defined in different ways:

- File: Terraform will automatically load files called `terraform.tfvars` or `*.auto.tfvars` (e.g. `production.tfvars`) and read the values defined there into the declared variables. The file uses HCL syntax. 
- Environment variables: Terraform will read any environment variables that start with `TF_VAR_` and assign them to the declared variables. The name of the variable is the part after `TF_VAR_` (e.g. `TF_VAR_region` will be assigned to the `region` variable).
- CLI Arguments: Terraform will read any command line arguments that start with `-var` or `-var-file` and assign them to the declared variables. The syntax is `-var="region=us-east-1"` or `-var-file="production.tfvars"`.

Precedence:

Environment variables > `terraform.tfvars` > `*.auto.tfvars` > `-var` > `-var-file`


# Output Variables

Output variables are used to expose information about the infrastructure. They are defined in the root module or a child module.

They are defined using the `output` block and normally stored in a different file (e.g. `outputs.tf`).

Each block allows for different arguments:
- `value`: the value of the output
- `description`: a description of the output
- `sensitive`: whether the output is sensitive (will not be shown in the output but **will be plainly visible in the state file**)

They can be called using the `terraform output` command. The `-json` and `-raw` flags can be used to change the output format and use the command in scripts or as part of pipelines.

# Locals

Locals are variables that are only used within the configuration. They are not exposed to the outside world. 

They can be used to avoid repetition and to make the configuration more readable.

They are declared using one or more `locals` blocks. Each variable can be assigned a static or computed (result of a function, reference to resource output, etc) value.

Example:

```hcl
locals {
  region = "us-east-1"
  azs    = ["a", "b", "c"]
}

resource "aws_instance" "example" {
  count = length(local.azs)

  ami           = "ami-abc123"
  instance_type = "t2.micro"
  availability_zone = local.azs[count.index]
  region = local.region
}
```

# Built-in variables

Terraform has a set of built-in variables that can be used in the configuration:

- `terraform.workspace`: the name of the current workspace
- `path.module`: the path to the module where the variable is used
- `path.root`: the path to the root module
- `path.cwd`: the path to the current working directory
  
Inside resource blocks, the following variables are also available:

- `count.index`: the index of the current resource (if using the `count` argument)
- `each.key`/`each.value`: the key/value of the current resource (if using the `for_each` argument)
- `self`: the resource object itself. It can be used to access attributes of the resource (e.g. `self.id`)