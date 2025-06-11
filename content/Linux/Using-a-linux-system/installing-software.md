---
title: "Installing Software"
date: 2023-01-14T11:02:09+01:00
weight: 1
draft: false
---

## Packages

A package in the linux distributions is a compressed archive that contains all necessary files for a software to run in the system. 

This includes among others:
- Binaries
- Configuration files
- Metadata

{{% notice style="warning" title="Dependencies" %}}
The compressed package does not include other software that it needs to run. This "dependencies" are the main reason package managers exist
{{% /notice %}}

## Package managers

Package managers help with the following when dealing with packages:

- Installation (Decompression, copying files)
- Upgrading
- Configuration
- Removal
- Integrity checks (comes from a trusted source, checksum check, etc.)
- Deal with dependencies

 Here is a general overview of the common managers used to install packages on different Linux distributions:

- Debian and Ubuntu: Software is typically installed using the `apt` package manager. Low level manager is normally `dpkg`
- Red Hat and Fedora: Software is typically installed using the `yum` or `dnf` package manager. Low level manager is normally `rpm`
- SUSE Family: Software is typically installed using the `zypper` package manager. Low level manager is normally `rpm`
- Other distributions: Some other Linux distributions, such as Slackware, use their own package management systems. 


As seen above, all linux distributions have a low level and a high level package manager:
- The low level, is in charge of installing single packages correctly. 
- The high level usually calls the low level one and additionally, is in charge of resolving dependencies.

{{% notice style="tip" title="Other ways of installing" %}}
It's also worth noting that there are other ways to install software on Linux, such as downloading binaries, compiling from source code, using flatpak, or using `snap` which is increasingly popular, but package managers are the most common and recommended method.
{{% /notice %}}

## Common operations

| Operation                              | RH Family                                      | Debian Family                                                                       |
| -------------------------------------- | ---------------------------------------------- | ----------------------------------------------------------------------------------- |
| Install package                        | `rpm -i foo.rpm`                               | `dpkg -i foo.deb`                                                                   |
| Install package, dependencies          | `yum/dnf install foo`                          | `apt-get install foo` or `apt install foo`                                          |
| Remove package                         | `rpm -e foo.rpm`                               | `dpkg -r foo.deb`                                                                   |
| Remove package, dependencies           | `yum/dnf remove foo`                           | `apt-get remove foo` or `apt remove foo`                                            |
| Remove package, deps, and config       |                                                | `apt-get remove --purge foo` or `apt purge foo`                                     |
| Remove "left-behind" packages          | `yum/dnf autoremove`                           | `apt-get autoremove` or `apt autoremove`                                            |
| Update package                         | `rpm -U foo.rpm`                               | `dpkg -i foo.deb`                                                                   |
| Update package, dependencies           | `yum/dnf update foo `                          | ` apt-get install foo`                                                              |
| Update entire system                   | `yum/dnf update`                               | `apt upgrade` to upgrade all packages, `apt-get dist-upgrade` to upgrade OS as well |
| Show all installed packages            | `rpm -qa` or  `yum/dnf list installed`         | `dpkg -l` or `apt list --installed`                                                 |
| Get information on package             | `rpm -qil foo`                                 | ``dpkg -s foo` for status, `dpkg --listfiles foo` to see the package files          |
| Show packages named foo                | `yum/dnf list "foo"`                           | `apt-cache search foo` or `apt search foo`                                          |
| Show all available packages            | `yum/dnf list`                                 | ` apt-cache dumpavail foo`                                                          |
| What package is file part of?          | `rpm -qf file`                                 | `dpkg --search file`                                                                |
| Edit repository sources                |                                                | `apt edit-sources`                                                                  |
| Dry run install to check for conflicts | `rpm -i --test`                                | `-`                                                                                 |
| What package provides a command        | `rpm --whatprovides x` or `yum/dnf provides x` | `-`                                                                                 |


## Debian-based distributions

{{% notice style="note" title="APT and APT-GET" %}}
`apt` and `apt-get` are both package management tools for Debian and Ubuntu-based Linux distributions but apt is a more user-friendly tool, abstracting some of the functionality from other commands. `apt-get` is considered to be more powerful and flexible, and mostly used in automation for the `-y` option for example.
{{% /notice %}}

### Repositories

`apt` (or `apt-get`) stores a list of repositories or software channels in the file `/etc/apt/sources.list`
and in any file with the suffix `.list` under the directory `/etc/apt/sources.list.d/`

A software repository is a collection of software packages that can be installed on the system. These packages are organized and managed by Ubuntu developers and are easily accessible to users via the apt package manager.

By editing these files from the command line, we can add, remove, or temporarily disable software repositories.

#### Format
A typical line on the file looks like this:
```sh
deb http://ch.archive.ubuntu.com/ubuntu/ saucy main restricted
```

- `deb`: These repositories contain binaries or precompiled packages. These repositories are required for most users.
- `deb-src`: These repositories contain the source code of the packages. Useful for developers.
- `http://archive.ubuntu.com/ubuntu`: The URI (Uniform Resource Identifier), in this case a location on the internet.
- `saucy` is the release name or version of the distribution (found with `lsb_release -sc`).
- `main` & `restricted` are the section names or components. There can be several section names, separated by spaces.

#### Adding new repositories

Adding a new line with the above format will add a new repository. To "load" them is important to retrieve the updated package list with

```bash
sudo apt-get update
```

{{% notice style="tip" title="PPA Repositories" %}}
Adding Launchpad PPA (Personal Package Archive) is possible conveniently via the command `add-apt-repository` in Ubuntu or `addrepo` on Debian. It looks like: `sudo add-apt-repository ppa:<repository-name>`
{{% /notice %}}
