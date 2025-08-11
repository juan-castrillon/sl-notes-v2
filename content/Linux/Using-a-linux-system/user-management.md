---
title: "User Management"
date: 2025-08-11T15:58:40+02:00
draft: false
---

Linux provides command-line tools for creating, modifying, and removing user and group accounts.

### Creating and Deleting Users

To create a new local user:

```bash
useradd bob
```

One can add options such as `-m` to create a home directory or `-s /bin/bash` to set the default shell.

{{% notice style="tip" title="Interactive user creation" %}}
When creating the user in person (not from a script) a much better alternative is `adduser`. This is an interactive script that creates the user and also directly sets a password
{{% /notice %}}

Set the password with:

```bash
passwd bob
```

To delete a user:

```bash
userdel bob
```

By default, this keeps the user’s home directory; add `-r` to remove it.

### User Management

See current user:

```bash
whoami
```

See which users are logged in:

```bash
who
```

Display current (or other) user and group identity:

```bash
id
id bob
```

View the last logged in users

```bash
last
```

### Group Management

Create a new group:

```bash
groupadd -g 1050 developers
```

{{% notice style="note" %}}
`-g` can also be skipped to use a generated ID
{{% /notice %}}

Delete a group:

```bash
groupdel developers
```

### Modifying Users

Change password expiration settings:

```bash
chage bob
```

Check which groups a user belongs to:

```bash
groups bob
```

Add a user to a supplementary group:

```bash
usermod -aG sudo bob # Attach to group
```