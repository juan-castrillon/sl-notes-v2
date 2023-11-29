---
title: "Language"
draft: true
---

Terraform files (normally with the extension `.tf`) are written in HashiCorp Configuration Language (HCL). It is a declarative language, meaning that you describe the desired state of the infrastructure, and Terraform will figure out how to create that state.

# Basic Syntax

The main building block of HCL is the **block**. It is defined by a block type, a label and a body:

```hcl
block_type label {
  key = "value"
}
```

Here:

- Values can be strings, numbers, booleans, lists or maps. They can also be references to other objects or variables.