---
title: "Standard Structure"
date: 2023-11-10T18:45:24+01:00
draft: true
---

Terraform modules should follow a standard structure to make them easier to use and maintain. The following structure is recommended:

```
ROOT
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── LICENSE
├── modules
│   ├── module1
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── module2
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │   
```

- `README.md`: Contains the documentation of the module and how to use it.
- `main.tf`: Contains the resources of the module.
- `variables.tf`: Contains the input variables of the module.
- `outputs.tf`: Contains the outputs of the module.
- `LICENSE`: Contains the license of the module.

### Nested modules

Modules can be nested to create more complex modules. For example, a module that creates a VPC can be composed of a module that creates the subnets and a module that creates the routing tables.

- They should be placed in the `modules` directory in the root module.
- If they contain a `README.md` file, it is deemed as a public module usable by external users. If not, it is deemed as a private module only usable by the root module.
- Relative paths should be avoided when referencing nested modules. 