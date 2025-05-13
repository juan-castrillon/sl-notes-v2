---
title: "Ansible"
draft: false
---

Ansible is a configuration management tool whose main purpose is to help **automatically** provision servers

In a standard architecture, a machine (called an *ansible control host*) serves as a middle man between the operator of ansible (me) and the servers to provision. This control host connects directly to the servers (via SSH) and issues commands to provision them. 

An alternative to this, is to have the operator workstation (my laptop), act as a control host directly, skipping the machine in the middle. 

![](/images/Ansible/general.jpg)

> Its important to highlight that in both of these setups, the servers to be provisioned **don't** have Ansible installed