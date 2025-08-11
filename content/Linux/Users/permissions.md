---
title: "Permissions"
date: 2023-01-14T11:25:24+01:00
draft: false
---


In Linux, file permissions control **who can read, modify, or execute** files and directories. Every file has an owner, a group, and a set of permissions that define access for the owner, the group, and everyone else (others).

## The Permission String

A typical long-format `ls` output looks like this:

```bash
-rwxrwxr-x
```

This string is divided into sections:

1. **File type** – The first character indicates the type:

   * `-` for a regular file
   * `d` for a directory
   * `l` for a symbolic link
   * `s` for a socket
   * `b` for a block device

2. **Owner permissions** – Next three characters (e.g., `rwx`) show what the file’s owner can do.

3. **Group permissions** – Following three characters show access for members of the file’s group.

4. **Others permissions** – Final three characters show access for everyone else.

Each permission is represented by a letter:

* `r` (**read**) → value 4
* `w` (**write**) → value 2
* `x` (**execute**) → value 1

The numeric values are used for **octal notation**.

### Permissions for Directories

Permissions on directories behave slightly differently:

* **Read (`r`)** – Allows listing directory contents.
* **Write (`w`)** – Allows creating, deleting, or renaming files in the directory.
* **Execute (`x`)** – Allows entering the directory with `cd`. Without `r`, you can enter but not list files.

## How Permissions Are Checked

When one access a file, Linux checks permissions in order:

1. If you are the **owner**, only the owner’s permissions apply.
2. If not, but you are in the **group**, group permissions apply.
3. Otherwise, **others** permissions apply.

This means even if “others” have full access, the owner may be restricted if the owner’s permissions are limited.

Example:
If a file has `--xrwxrwx` and is owned by `bob:bob`, Bob cannot read it because owner permissions are checked first.

## Changing Permissions

The `chmod` command modifies file permissions.

### Octal Notation

Add the values for each permission:

* `rwx` → 4 + 2 + 1 = **7**
* `rw-` → 4 + 2 + 0 = **6**
* `r--` → 4 + 0 + 0 = **4**

Example: Grant full permissions to the owner, read/execute to group and others:

```bash
chmod 755 file
```

### Symbolic Notation

Symbolic mode is more descriptive:

* **Who**: `u` (user/owner), `g` (group), `o` (others)
* **Action**: `+` (add), `-` (remove)
* **What**: `r`, `w`, `x`

Examples:

```bash
chmod ugo+r-x file
chmod u+r-x,g---,o--- file
```

## Changing Ownership

* **Change owner**:

```bash
chown alice file
```

* **Change group**:

```bash
chgrp developers file
```
