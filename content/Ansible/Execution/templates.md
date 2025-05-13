---
title: "Templates"
date: 2025-05-13T08:07:16+02:00
draft: false
---

Ansible templates are files used to dynamically generate configuration files or scripts. These templates are written using the Jinja2 templating language, which allows to include variables, loops, conditionals, and more.

Templates are typically stored in the `templates` directory of an Ansible role or playbook, and they are processed by the `template` module in Ansible. When you use this module, you specify the source template file and the destination path on the target machine. During execution, Ansible replaces any variables and expressions in the template with their corresponding values.

### Example of Using a Template in Ansible

Here’s an example of a simple template file (`config.j2`):

```jinja2
server_name = {{ inventory_hostname }}
port = {{ http_port }}
```

To deploy this template, use the following task in your playbook:

```yaml
- name: Deploy configuration file
  template:
    src: config.j2
    dest: /etc/myapp/config.conf
```

This task would create a file `/etc/myapp/config.conf` on the target machine with the variables replaced by their actual values from the playbook or inventory.
