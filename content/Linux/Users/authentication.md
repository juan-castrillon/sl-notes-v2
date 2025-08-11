---
title: "Authentication and Management"
date: 2023-01-14T11:25:30+01:00
draft: false
---

In linux, authentication is based on a username/password model. Although it can be somehow extended (e.g PAM, SELinux) this is the base of controlling who can access a linux system.

## User and Group Accounts

A user account is the basic authentication unit of a linux system. It contains the following information:

- Username
- Password: Normally stored encrypted in `etc/shadow` (Uses a format `USER:PASS:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE`)
- Unique Identifier (UID):  A number that uniquely identifies the account to the system. While usernames are for humans, UIDs are for the operating system.
- Group Unique Identifier (GID): The numerical identifier of the user’s primary group. Groups are used to manage permissions collectively
- Home Directory
- Default Shell

Information about stored accounts can be seen in `/etc/passwd`, which lists all system users and their associated information in a colon-separated format. A sample entry might look like:

```
alice:x:1001:1001:Alice Example:/home/alice:/bin/bash
```

Here, `x` indicates that the password is stored in `/etc/shadow`.

### Groups

Groups allow to create collections of users and then manage permissions on those collection instead of multiple times in each user. 

Information about groups can be seen in `/etc/group`. This file uses a format `NAME:PASS:GID:MEMBERS`

### Other types of accounts

Apart from normal user accounts, the linux systems use some special accounts:

#### Superuser account (`root`)

The **superuser** (username `root`) has a UID of `0`. This account can do anything on the system, including:

* Managing user accounts
* Installing and removing software
* Modifying system files
* Starting or stopping system services

Because of its unrestricted power, the root account should be used sparingly, usually through commands like `sudo` that temporarily grant elevated privileges.

#### System accounts

During the operating system installation, Linux creates **system accounts** with low UIDs—typically below 100 on modern distributions (though older systems used 500–1000 for regular users). These accounts are not intended for human logins. Instead, they belong to system processes and components. For example, an account might be dedicated to running the `mail` subsystem or managing logs.

These normally have no shell or home directories.


#### Service accounts


When software packages are installed, they may create their own **service accounts**. These accounts exist solely so the service can run under a dedicated identity, improving security. If a service is compromised, the attacker is limited by that account’s permissions rather than having access to the whole system. For instance, a web server might run as the `www-data` user with restricted access to only its configuration files and web content.


## Switching Users

There are two main ways to switch identities:

- **`sudo`** – Run commands as another user (often root) without logging in as them. Configuration is in `/etc/sudoers` or `/etc/sudoers.d/`.
  The file should be edited with `visudo` to prevent syntax errors. A typical rule format is:

  ```
  who where = (as_whom) what
  ```

  Example: `alice ALL=(ALL) /usr/bin/systemctl` allows `alice` to run `systemctl` as any user.
  Commands and failed attempts are logged (`/var/log/auth.log` on Debian, `/var/log/secure` or `/var/log/messages` on others).

  Useful commands include:

  ```bash
  sudo command # Run command as the root user
  sudo -i # Login shell as the root user, env is read
  sudo -iu user2 # Same but with non root user
  ```

- **`su`** – Switch to another user by providing their password. It’s less common for becoming root, as `sudo` is more secure and auditable.
