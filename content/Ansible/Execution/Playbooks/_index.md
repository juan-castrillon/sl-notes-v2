---
title: "Playbooks"
draft: false
---

Ansible Playbooks offer a repeatable, reusable, simple configuration management and multi-machine deployment system. They are files that allow to define a set of instructions to execute to reach a desired state. Sames as the [ad-hoc]({< ref "ansible/execution/adhoc" >}}) commands, they make use of modules to execute things. 

They are written in YAML format and run with the `ansible-playbook` binary

```bash
ansible-playbook -K my_plabook.yml
```

An example of a simple playbook can be seen below:

```yaml
- name: Install apache # Name of the whole playbook
  hosts: all # Running on all nodes
  become: true # Same as --become, run this as root
  tasks:
  - name: install apache2 package # Name of the task
    apt: # Using the builtin apt module
      name: apache2 # Name of the package to install
      update_cache: true # Before installing run apt update
```

More modules, and options can be added to achieve complex behaviors.

## Running a playbook

When running a playbook, ansible first always runs a `gather_facts` task to gain information on the servers. After running, the results will be summarized in the `PLAY RECAP`, for example:

```bash
ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

This gives an overview of what the command achieved and wheter or not it succeded
- `ok` shows the tasks that did not fail (always 1 plus because of the `gather_facts` tasks)
- `changed` shows the tasks that actually changed something in the server (Running an install task twice will only change once)
- `unreachable` will report if the server could not be reached while running the task
- `skipped` will make sense for conditional tasks (that run depending if something is true)