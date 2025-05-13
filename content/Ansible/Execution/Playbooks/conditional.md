---
title: "Conditional Tasks"
date: 2025-05-12T17:43:24+02:00
draft: false
---

## `when` keyword

Conditional logic can be introduced into Ansible playbooks using the `when` keyword. This allows to define a condition to execute a task. Any variable, including the ones resulted from `gather_facts`, can be used for the condition. This means, that if a task should only run on Ubuntu servers, the task could look like this:

```yaml
  - name: install apache2 package # Name of the task
    apt: # Using the builtin apt module
      name: apache2 # Name of the package to install
      update_cache: true # Before installing run apt update
    when: ansible_distribution == "Ubuntu"
```

> `gather_facts` can be called as an ad-hoc task `ansible -m gather_facts` to see the different variables and values available


## `hosts` and groups

Another way to conditionally execute a playbook is to group the servers (based on characteristics, function, etc) and then using the `hosts` entry in the plays to target the different groups

```yaml
---
- name: Update packages
  hosts: all # Running on all nodes
  become: true 
  tasks:
  - name: install updates (centos)
    dnf:
      update_only: yes
      update_cache: yes
    when: ansible_distribution == "CentOS"

- name: Provision web servers
  hosts: web_servers
  become: true
  tasks:
  - name: install apache2 package and php support (centos)
    dnf:
      name: 
        - httpd
        - php
      state: latest
    when: ansible_distribution == "CentOS"

- name: Provision dbs
  hosts: db_servers
  become: true
  tasks:
    - name: install mariadb (centos)
      dnf:
        name: mariadb
        state: latest
```

With an inventory that looks like

```ini
[web_servers]
1.2.3.4

[db_servers]
5.6.7.8.9
```

## Tags

To focus (or skip) certain tasks from the playbook explicitly, tags can be used. This metadata allows ansible to just run or skip certain tasks. This helps to target particular architecture, quickly debug changes, etc. 

Tags are defined in the different tasks as a comma separated string

```yaml
- name: Update packages
  tags: always
  hosts: all # Running on all nodes
  become: true 
  tasks:
  - name: install updates (centos)
    dnf:
      update_only: yes
      update_cache: yes
    when: ansible_ditribution == "CentOS"

- name: Provision web servers
  tags: web_servers,centos
  hosts: web_servers
  become: true
  tasks:
  - name: install apache2 package and php support (centos)
    dnf:
      name: 
        - httpd
        - php
      state: latest
    when: ansible_ditribution == "CentOS"
```

Using the cli, `ansible-playbook --list-tags playbook.yml` can be used to see available tags. At the same time `ansible-playbook --tags centos` can be used to run only tasks that have a tag, with the opposite being `ansible-playbook --skip-tags centos`

The special keywords `always` and `never` can be used in the tags to guarantee that no matter which tags are passed, a task always (or never) runs.