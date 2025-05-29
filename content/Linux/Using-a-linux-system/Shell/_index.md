---
title: "Shell"
draft: false
---

The shell in linux is a program that allows the user to interact with the underlying OS by sending text commands. 

Popular shells include:
- Bourne Again Shell (`bash`)
- `zsh`
- `sh`

Current shell can be determined reading the environment variable `$SHELL`. Furthermore, using

```bash
chsh
```

Allows one to change the shell for the user

{{% notice style="note" title="Assumed shell" %}}
In these docs, it is assumed the shell is `bash`
{{% /notice %}}


## Command types

Command come in two types. The command `type`  can be used with a command as argument to verify which type a certain command is

1. **Internal**: Come built in with the shell. E.g. `echo`
2. **External**: Are binaries installed in the system. E.g `git`, `mv`



## Environment Variables

Environment variables are user-definable values that affect how running processes behave on the system. The OS sets up a group of variables by default. At any time, the set up environment variables for a user can be seen with

```bash
printenv
```

To create environment variables, there is two options

1. `export FOO=bar`: This will make the variable extend to all processes created from this shell
2. `FOO=bar`: The variable will not go further