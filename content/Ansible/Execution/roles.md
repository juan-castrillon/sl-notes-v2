---
title: "Roles"
date: 2025-05-12T17:46:51+02:00
draft: false
---

- Roles are a way to organize ansible tasks (not plays) in order to allow them to be reused and easily shared
- They provide a predefined structure that allows to group tasks with variables, templates, files, etc. 
- Similar to modules in terraform
- In the playbooks they can be called like:

```yaml
- hosts: all
  become: true
  roles:
    - myrole
```

Roles can also be used in a task with `import_role`. When running with `roles` ansible will execute the roles after any `pre_task` but before any other task in the play. When calling it from a task with `import_role` the order is respected. 

Most importantly, `import_roles` is dynamic, which allows to do things like have variables for the role name, use loops to execute them, skip them. 

```yaml
---
- hosts: webservers
  tasks:
    - name: Print a message
      ansible.builtin.debug:
        msg: "this task runs before the example role"

    - name: Include the example role
      include_role:
        name: example

    - name: Print a message
      ansible.builtin.debug:
        msg: "this task runs after the example role"
```

{{% notice style="tip" %}}
If not using the `roles` directory, a path can be passed instead of just the name{{% /notice %}}


## Defined Structure

For each role, ansible expect a folder inside the `roles` directory named as the role (e.g `roles/myrole`)

Inside each role folder, the following structure is standard:

- `tasks` to put the taskbooks in, with the default one always being `main.yml`
- `defaults` to put low precedence default values for role variables in, with the default one always being `main.yml`
- `handlers` to put the handlers that will be imported in the parent play in, with the default one always being `main.yml`
- `vars` to put high precedence variables provided by the role  with the default one always being `main.yml`
- `files` to put any files referenced in the role tasks (like in `copy`)
- `templates` to put any role templates
- `metadata` metadata for the role, including role dependencies and optional Galaxy metadata such as platforms supported. This is required for uploading into galaxy as a standalone role, but not for using the role in your play. With the default one always being `main.yml`


> The command `ansible-galaxy init role_name` can be used to initialize this folder directory quickly


## Sharing roles

- Roles can be downloaded and shared via ansible galaxy, which is  an online open-source, public repository of Ansible content
- Community roles can be installed and then called from playbooks