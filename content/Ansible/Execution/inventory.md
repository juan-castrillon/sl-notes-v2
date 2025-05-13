---
title: "Inventory"
date: 2025-05-12T17:29:21+02:00
draft: false
---

To know which machines are available to control, ansible needs an inventory. This simply describes (with the ip addresses) which machines are to be controlled.

The simplest inventory is a single file with a list of hosts and groups. The default location for this file is `/etc/ansible/hosts`. However, using the `-i <path or expression>` option(s) or using the configuration system the file can be changed.

## Grouping

The inventory files allow also to group and set up different configuration values for each server. They can be defined in `ini` or `yaml` formats (depending what is easier to read given the architecture)

Even if no groups are defined in the inventory file, Ansible creates two default groups: `all` and `ungrouped`. The `all` group contains every host. The ungrouped group contains all hosts that don’t have another group aside from `all`. Threfore every host will always belong to at least 2 groups (`all` and `ungrouped` or `all` and some other group)

Once the inventory is organized, commands can be run on all host in a group with:
```bash
ansible mygroup ...
ansible all ...
```

More information can be found in the [documentation](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#how-to-build-your-inventory)


## Dynamic inventories

Inventory plugins can be utilized to create dynamic inventories, based on cloud providers API or other resources. This can be used in combination with static inventories to reflect complex setups



