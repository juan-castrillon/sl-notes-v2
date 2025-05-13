---
title: "Handlers"
date: 2025-05-12T17:50:43+02:00
draft: false
---

There is a "special" kind of tasks called handlers, which only run when triggered by changes in another tasks.

This behavior substitutes the pattern of combining `register` with `when: var changed`. It allows for more flexibility and easier management when multiple tasks can trigger the same handler


In roles, there is a `handlers` directory to place them, but they can also be added to a playbook.


They are triggered by `notify` and their name, which **must** be static (more info [here](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_handlers.html#using-variables-with-handlers))


Multiple tasks can trigger a handler. Notifying the same handler multiple times will result in executing the handler only once regardless of how many tasks notify it.

In the same way, a task can have multiple `notify`. It is important to note here that handlers are executed in the order they are defined in the handlers section, not in the order listed in the notify statement.

Example:

```yaml
tasks:
- name: Template configuration file
  ansible.builtin.template:
    src: template.j2
    dest: /etc/foo.conf
  notify:
    - Restart memcached

handlers:
  - name: Restart memcached
    ansible.builtin.service:
      name: memcached
      state: restarted
```