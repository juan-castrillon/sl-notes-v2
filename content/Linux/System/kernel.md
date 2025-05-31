---
title: "Kernel"
date: 2025-05-31T19:52:30+02:00
draft: false
---

The linux kernel is the main component in all linux distributions. It serves as the core interface between computer hardware and application processes, allowing the applications to talk to the underlying physical devices. 

![](/images/Linux/kernel.png)

{{% notice style="info" title="Modules" %}}
The kernel is a monolithic (handling most tasks on itself) software, but it is extensible using modules
{{% /notice %}}

The kernel is responsible for many critical tasks like:

- **Memory Management**
  - It keeps track of the memory used/free and which process are using/needing memory
  - Divides the memory into two spaces
    - Kernel space: Processes that the kernel starts, and are needed for the system to run, these have unrestricted access to resources
    - User space: All other processes, access to resources is controlled and limited to certain extend.
- **Process Management**
  - Control which processes can access resources (e.g CPU) and for how long
- **Device drivers**
  - Act as "interpreter" between applications and underlying hardware
- **System calls**
  - Processes communicate with the kernel via functions (system calls) that the kernel processes and executes (e.g `open()` to open a file)

{{% notice style="tip" title="title" %}}
To check the existing kernel version running in a system the following command can be used:

```bash
uname -r
```
{{% /notice %}}