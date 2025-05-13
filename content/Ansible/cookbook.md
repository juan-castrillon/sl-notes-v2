---
title: "Cookbook"
date: 2025-05-13T08:08:43+02:00
draft: false
---

## Copying a file

- For this the `copy` module can be used
- For example:

```yaml
- name: Send custom html page
    copy:
      src: default_site.html # files directory is assumed
      dest: /var/www/html/index.html
      owner: root
      group: root
      mode: 0644
```

## Unzipping a file

- `unarchive` module can be used
- It supports downloading a file directly

```yaml
- name: Install terraform
  unarchive: # Needs unzip installed
    src: https://releases.hashicorp.com/terraform/0.12.28|terraform_0.12.28_linux_amd64.zip
    dest: /usr/local/bin
    remote_src: yes
    mode: 0755
    owner: root
    group: root
```

## Change lines in config files

- The `lineinfile` module allows to match a file and replace it in the target server
- It needs to be tested before hand, as any typo can lead to duplicate lines in the file leading to misconfiguration

```yaml
- name: change e-mail address for admin
     lineinfile:
       path: /etc/httpd/conf/httpd.conf
       regexp: '^ServerAdmin'
       line: ServerAdmin somebody@somewhere.net
     when: ansible_distribution == "CentOS"
     register: httpd
```

## Manage Services

- Services can be managed, started, restarted, enabled, etc. from ansible using the `service` module
- This is a generic module that acts  acts as a proxy to the underlying service manager module (like `systemd`) so not all options are available (similar to `package` module and `apt` or `dnf`)

```yaml
- name: Start and enable httpd in a CentOS machine
  service:
    name: httpd
    state: started
    enabled: true

- name: change e-mail address for admin
  lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^ServerAdmin'
    line: ServerAdmin somebody@somewhere.net
  when: ansible_distribution == "CentOS"
  register: httpd
 
- name: restart httpd (CentOS) only if the config file was changed
  service:
    name: httpd
    state: restarted
  when: httpd.changed 
```

## User management

- Several modules in ansible allow admins to do user management on the servers like `builtin.user` or `posix.authorized_key`
- A very common use case is to have a bootstrap playbook to provision a user which then ansible can use for other playbooks (by having passwordless sudo for example)

```yaml
- hosts: all
  become: true
  tasks:

  - name: create simone user
    user:
      name: simone
      groups: root
    
  - name: add ssh key for simone
    authorized_key:
      user: simone
      key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAe7/ofWLNBq3+fRn3UmgAizdicLs9vcS4Oj8VSOD1S/ ansible"
        
  - name: add sudoers file for simone
    copy:
      content: 'simone ALL=(ALL) NOPASSWD: ALL'
      dest: /etc/sudoers.d/simone
      owner: root
      group: root
      mode: 0440
```