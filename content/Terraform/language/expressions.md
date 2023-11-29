---
title: "Expressions"
date: 2023-11-07T18:09:52+01:00
draft: false
---

Expressions are used to refer to or compute values within a configuration. Expressions are used in a number of situations, most commonly in argument values for resources and data sources to express values that cannot be determined until apply time.

# Types 

- Primitive Types: 
  - Boolean: `true` or `false`
  - Number: `42` or `3.1415`
  - String: `"Hello, World"`
    - Normally double-quoted, but single-quoted is also valid
    - DOuble quotes allow for escape sequences like `\n` for newline and also special escapes like `$${` to include a literal `${` in the string or `%%{` to avoid using interpolation and template syntax.
    - Heredoc syntax is also supported for multi-line strings. (`<<EOF` and `EOF`)

- No Type: `null` (Represents the absence of a value, when wanting to use the default value of an argument)

- Complex Types:
  - List/Tuple: `[1, 2, 3]` (Ordered, indexed, zero-based)
    - Tuple allows for elements of different types
  - Set: `["one", "two", "three"]` (Unique values, unordered, same type(will be casted to match the first element))
  - Map: `{ "one" = 1, "two" = 2 }` (All values must be of the same type)
  - Object: `{ one = 1, two = 2, three = "three" }` (Similar to a map, but can have different types of values)


# String Templates

## Interpolation

- Interpolation is used to insert the value of an expression into a string.
- Interpolation is indicated by the `${` sequence, and terminated by the `}` character.

Example:

```hcl
Name = "HelloWorld-${var.environment}"
```

## Directives

- Directives allow for conditional results and iteration over collections inside of a string template.
- Directives are indicated by the `%{` sequence, and terminated by the `}` character.

Example:

```hcl
"Hello, %{ if var.name != "" }${var.name}%{ else }unnamed%{ endif }!"
<<EOT
%{ for ip in aws_instance.example[*].private_ip }
server ${ip}
%{ endfor }
EOT
```

> Whitespace can be trimmed when using directives by adding the `~` at the end of the sequence. Example: `%{ if var.name != "" ~}`. Similar to go `{{-` and `-}}`.


# Operators

## Arithmetic Operators
- `+` Addition
- `-` Subtraction
- `*` Multiplication
- `/` Division
- `%` Modulo
- `-a` Flip to negative

## Comparison Operators
- `==` Equal
- `!=` Not Equal
- `>` Greater Than
- `>=` Greater Than or Equal
- `<` Less Than
- `<=` Less Than or Equal
- `&&` Logical AND
- `||` Logical OR
- `!` Logical NOT

## Conditional Operators
- `condition ? trueVal : falseVal` Ternary Operator
  - Return type of if and else must be the same

# For Loops

- `for` loops can be used to iterate over complex types (lists, sets, maps, objects, tuples)

## Types of For Loops

- `for s in list`: Iterates over a list, tuple or set, assigning each element to the variable `s`.
- `for k, v in map`: Iterates over a map, assigning each key to the variable `k` and each value to the variable `v`.
- `for k, v in object`: Iterates over an object, assigning each key to the variable `k` and each value to the variable `v`.
- `for i, v in list`: Iterates over a list,tuple or set assigning each index to the variable `i` and each value to the variable `v`.

## Output type

- The output type of the expression is determined by the first and last character of the expression.
- `[for ...]` Tuple
- `{for ...}` Object
  - For this the special operator `=>` can be used to specify the key and value of the object.
  - Example: `{ for s in list: s => upper(s) }` 

## Reductions

- Conditional expressions can be used inside of a for expression to filter the results.
- Example: `[for s in list: s if s != ""]` will return a list with all the elements of the list that are not empty strings.


# Splat Expression

- Short version of `for` expression.
- Normally used to get values from lists, sets and tuples
- `[ for s in list: s.id ]` is equivalent to `list[*].id`
- When used with anything that is not a list, it will return a list if the value is not `null`  or an empty list if the value is `null`. This is normally used in `for_each` arguments to support optional values.

# Dynamic Blocks

- Dynamic blocks allow for repeating a nested block within a resource or module.
- They have a `for_each` argument that can be used to iterate over a map or set and a `content` argument that contains the nested block.
- The type of the block is given in the tag of the dynamic block.
- The `iterator` argument can be used to specify the name of the variable that will be used to refer to the current element in the iteration. Otherwise, the name of the block will be used.

Example:

The following:

```hcl
locals {
  ebs_block_device = [1, 2]
}

resource "aws_instance" "example" {
  dynamic "ebs_block_device" {
    for_each = local.ebs_block_device
    content {
      device_name = "/dev/sdh${ebs_block_device.value}"
      volume_size = 10
      volume_type = "gp2"
    }
  }
}
```

Is equivalent to:

```hcl

resource "aws_instance" "example" {
  ebs_block_device {
    device_name = "/dev/sdh1"
    volume_size = 10
    volume_type = "gp2"
  }

  ebs_block_device {
    device_name = "/dev/sdh2"
    volume_size = 10
    volume_type = "gp2"
  }
}
```

# Version Constraints

- Version constraints can be used to specify the version of a provider or module.
- Uses semantic versioning.
- `=` Exact version
- `>=` Greater than or equal to
- `<=` Less than or equal to
- `~>` Greater than or equal to the specified version, but less than the next minor version.
  - Example: `~> 2.0.0` is equivalent to `>= 2.0.0, < 2.1`