---
title: "Ad-hoc commands"
date: 2025-05-12T17:36:00+02:00
draft: false
---

Although the core of ansible is using playbooks, the cli tool can be used to directly execute commands or run modules. They work great for tasks that are run not that often or tests.  

For running a command the following is needed:
- Inventory group name 
- Key to use when connecting via SSH
- Inventory file location
- Module or command

This can all be passed in the cli. For example, the following command uses the `ping` [module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ping_module.html) to verify connection to all servers:

```bash
ansible all --key-file ansible.key -i inventory.ini -m ping
```

Most of the repetitive values however, can be put inside a `ansible.cfg` file. A local file will override configuration in `/etc/ansible/ansible.cfg`. [Configuration](https://docs.ansible.com/ansible/latest/reference_appendices/config.html) can also be done via environment variables:

```cfg
[defaults]
inventory = inventory.ini
private_key_file = ./ansible.key
remote_user = ansible
```

That way, the following command (that uses the `gather_facts` module to get information of the servers) works:

```bash
ansible all -m gather_facts
```

## Elevated commands

Ansible uses existing privilege escalation systems to execute tasks with root privileges or with another user’s permissions. Because this feature allows one to ‘become’ another user, different from the user that logged into the machine (remote user), its called `become`. The `become` keyword uses existing privilege escalation tools like `sudo`, `su`, etc (using `sudo` by default)

If nothing else is specified, the `become` keyword will try to run the commands as the `root` user. The password can be passed via a file (using the `--become-password-file` option) or be prompted (`-K` or `--ask-become-pass`). More information can be seen in the [docs](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_privilege_escalation.html)

Example of ad-hoc elevated commands are:

- Update package cache in all servers (`apt update`)
    ```bash
    ansible all -m apt -a update_cache=true --become --ask-become-pass
    ```

- Update and upgrade all packages (`apt upgrade`)
    ```bash
    ansible all -m apt -a upgrade=yes --become --ask-become-pass
    ```