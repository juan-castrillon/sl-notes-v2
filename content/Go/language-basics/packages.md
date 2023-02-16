---
title: "Packages"
date: 2023-02-16T19:42:30+01:00
draft: false
---

Similar to libraries or modules in other languages, go uses the concept of packages to refer to reusable blocks of code that can be imported and used in other code. 

Working with packages is straight forward. One can:
- Declare packages: When structuring an application, to split the functionality logically
- Import packages: While coding to use functions from the standard library, third party packages or even other packages in the app

## Declaring packages

At the beginning of each `.go` file, the package of the file needs to be declared. It must be the first code to appear and can only be preceded by comments (most of the times documenting the package). Here is an example:

```go
// Package example contains a lot of invisible functions and variables
package example
```
{{% notice style="warning" title="Files in a package" %}}
All files in a directory **must** be in the same package. Most commonly the package is named after the directory where the files are. 
{{% /notice %}}

## Importing packages

Packages need to be imported to be used, this is done always in an `import` block at the beginning of the file:

```go
// This package will import some other
package example

import (
    "fmt"
    "github.com/someguy/apackage"
    other "github.com/otherguy/apackage"
)
```

In the example above:
- `fmt` is a package from the stdlib
- `github.com/someguy/apackage` is an example of a third party package
- `github.com/otherguy/apackage` is another third party package imported with the alias `other` to avoid naming conflicts when calling `apackage.afunction`

{{% notice style="warning" title="Used packages" %}}
Go has compile rules that enforce that every imported package **must** be used. This helps optimize binary sizes. An option to avoid this, is to use a *side effects import*, which just loads a package. This should **always** be done in the `package main` like

```go
import (
    "fmt"
    _ "sync" // Just for some effect
)
```
{{% /notice %}}