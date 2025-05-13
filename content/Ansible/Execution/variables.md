---
title: "Variables"
date: 2025-05-12T17:46:09+02:00
draft: false
---

Referenced in the playbook as `{{ name }}` variables allow for consolidation of playbooks as well as flexibility. 

Variables can be defined:
 
- In the inventory file. Particular values per host or group can be defined and will be picked up

```ini
[mygroup]
1.2.3.4 apache_package=apache2 

[mygroup:vars]
other_var=something
```

- In playbooks themselves using `vars` block or  `vars_file` for external files

- In a `host_vars` directory. In this standard directory, each file corresponds to a host (either IP or hostname) and ansible will pick up automatically the variables defined there for each host. Similarly a `group_vars` directory can be used where the name of the files are the name of the groups in the inventory. More info [here](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#organizing-host-and-group-variables)