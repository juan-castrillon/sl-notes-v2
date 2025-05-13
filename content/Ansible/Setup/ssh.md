---
title: "SSH"
date: 2025-05-12T17:23:59+02:00
draft: false
---

SSH needs to be configured, as it is the main way that ansible uses to send commands to the servers. This means that:

- The control node must have openssh client installed
- The servers must have openssh server installed

As general good practice, the use of ssh keys instead of passwords is recommended. There is multiple type of keys to generate, the example below generates a ED25519 key: 

```bash
ssh-keygen -t ed25519 -C "some key"
```

The key can have a password to unlock it. This is recommended for **personal** keys, but in the case of creating a key for ansible to use, it's better to skip it. 

Once a key is created it can be added to a server using the command:

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub <USER>@<IP>
```

For this the user must already exist in the machine, and the machine running the command should also have ssh access. 

{{% notice style="tip" title="Order of execution" %}}
The first time that a connection to a new server is established, the ssh client will ask for confirmation. It is common to do this first connection manually to avoid "messing" with Ansible when it tries to connect. Alternatively, ansible can also be [configured to automatically accept](https://stackoverflow.com/questions/32297456/how-to-ignore-ansible-ssh-authenticity-checking)
{{% /notice %}}

