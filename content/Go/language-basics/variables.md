---
title: "Variables"
date: 2023-02-16T19:42:50+01:00
draft: false
---

## Types

Go is a **statically typed** language. This means that variables are assigned a type when created and can only hold values of that type. This helps with avoiding runtime errors by catching them at compile-time

Go supports several types. The most common being

| Type        | Description                                                              | Zero Value     |
| ----------- | ------------------------------------------------------------------------ | -------------- |
| `int`       | Integer value, can be 64 or 32 bits depending on the system it runs on   | 0              |
| `bool`      | Boolean value                                                            | `false`        |
| `string`    | String of UTF-8 characters                                               | `""`           |
| slice       | Growable list of a type                                                  | `nil`          |
| map         | Key-value data structure                                                 | `nil`          |
| `struct`    | A collection of named attributes (Similar to objects in other languages) | Empty `struct` |
| `interface` | A type that holds a value with defined methods                           | `nil`          |
| pointers    | A type that stores an address in memory of a variable not the variable   | `nil`          |
| channels    | A pipe (buffered or not) for sending data asynchronously                 | `nil`          |

Other types include more control over the size of the variables, as well as some particular use cases like complex numbers:

| Type         | Description                                                               | Zero value |
| ------------ | ------------------------------------------------------------------------- | ---------- |
| `uint`       | Unsigned 32 or 64 bit integer                                             | 0          |
| `uint8`      | Unsigned 8 bit integer (0-255)                                            | 0          |
| `uint16`     | Unsigned 16 bit integer (0-65535)                                         | 0          |
| `uint32`     | Unsigned 32 bit integer (0-4294967295)                                    | 0          |
| `uint64`     | Unsigned 64 bit integer (0-18446744073709551615)                          | 0          |
| `int8`       | Signed 8 bit integer (-128-127)                                           | 0          |
| `int16`      | Signed 16 bit integer (-32768-32767)                                      | 0          |
| `int32`      | Signed 32 bit integer (-2147483648 - 2147483647)                          | 0          |
| `int64`      | Signed 64 bit integer (-9223372036854775808 - 9223372036854775807)        | 0          |
| `float32`    | 32 bit floating point (decimal) values                                    | 0          |
| `float64`    | 64 bit floating point (decimal) values                                    | 0          |
| `complex64`  | Complex numbers with real and imaginary part `float32`                    | `(0+0i)`   |
| `complex128` | Complex numbers with real and imaginary part `float64`                    | `(0+0i)`   |
| `byte`       | Alias for `uint8`                                                         | 0          |
| `rune`       | Alias for `int32`                                                         | 0          |
| `uintptr`    | Unsigned integer large enough to hold any pointer address (32 or 64 bit). | 0          |
| `array`      | Fix list of items                                                         | `[]`       |
| `function`   | A function can be stored in a variable (functional programming)           | `nil`      |

## Declaring variables

Go supports two types of variable declaration: 

1. Creation and assignment: This type can be used to declare variables at the package and function levels. If using just the creation statement (`var i int`) the variable will have the corresponding zero value

```go
var i int // Create for a given type
i = 3 // Assign the value
var j = 3 // Infers the type
```

2. Single statement: This can only be used in function levels

```go
i := 3 // Creates and infers the type, then assigns the value
```

{{% notice style="note" title="Redeclare variables" %}}
Once declared a value cannot be redeclared in the same scope, only a new value can be assigned, so the following is not valid

```go
func main() {
    i := 3
    i := 5
}
```
{{% /notice %}}

### Scope of variables

Depending on where they are declared variables can be "visible" to different scopes:

- Package scoped: When declared at the package level, it can be seen by the entire package

```go
package oe

var word = "hello"

func afunction(){}
```

- Function scoped: Only visible inside a particular function

```go
func afunction(){
    var i = 3
}

func another() {
    // i is not accessible
}

```

- Statement scoped: Only visible for an statement (loop, if) inside a function

```go
func af() {
    for i := 0; i < 10; i++ {
        // i is accessible
    }
    // i is not visible
}
```

#### Shadowing

Redeclaring variables in different scopes can affect the values that can be read. This is a very common bug know as variable shadowing. Below an example

```go
package main

var word = "hello"

func main(){
    var word = "world"
    // In this scope word is world
}

func other(){
    // In here word is hello
}

```