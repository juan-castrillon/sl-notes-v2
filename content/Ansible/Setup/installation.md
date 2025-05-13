---
title: "Installation"
date: 2025-05-12T17:24:08+02:00
draft: false
---

Ansible can be installed from their direct repository, using `pip` or directy from many linux distribution package stores. 

More info can be seen [here](https://docs.ansible.com/ansible-core/devel/installation_guide/installation_distros.html)

To install in ubuntu:

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```