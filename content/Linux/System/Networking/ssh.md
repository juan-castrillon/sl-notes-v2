---
title: "SSH"
date: 2025-08-11T16:36:48+02:00
draft: false
---


SSH (Secure Shell) is the standard method to securely connect to remote Linux servers. It encrypts all communication, preventing eavesdropping or tampering.

By default, SSH runs a server process listening on **port 22** on the remote machine. To connect, simply run:

```bash
ssh user@remote-server
```

If one omit the username, SSH assumes the local username.

## Passwordless Authentication with SSH Keys

For convenience and security, passwordless login is preferred. This uses a key pair:

* **Generate a key pair** on local machine:

  ```bash
  ssh-keygen -t rsa
  ```

* **Copy the public key** to the remote server:

  ```bash
  ssh-copy-id user@remote-server
  ```

Once done, the public key is added to the remote server’s `~/.ssh/authorized_keys` file, allowing the user to login without typing the password.


## SCP — Secure Copy Over SSH

SCP uses the SSH protocol to securely transfer files between local and remote systems.

To copy a local file to a remote server:

```bash
scp /path/to/local/file user@server:/path/to/destination/
```

For directories, use the recursive flag:

```bash
scp -r /local/directory user@server:/remote/path/
```

To preserve file permissions and timestamps during copy, add:

```bash
scp -p /local/file user@server:/remote/path/
```

{{% notice style="tip" %}}
Remember, the user needs write permissions on the destination folder to copy files successfully.
{{% /notice %}}


