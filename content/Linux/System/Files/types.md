---
title: "Types"
date: 2025-05-31T20:22:40+02:00
draft: false
---

Linux distinguishes 3 main categories of files:

1. Regular files
2. Directories
3. Special files

The command:

```bash
file <file>
```

can be used to determine the type of a file

### Special files

Under "special", linux understands all files that are not regular. They are:

#### Character files

These files, usually located in the `/dev` directory, represent devices that interact serially with the operating system (e.g., a mouse or keyboard).

#### Block files

These are also normally located in `/dev` but represent block devices (devices that read and write data in fixed-size blocks, such as hard disks and RAM )


#### Links

Links provide a way to relate two or more files in linux:

- **Hard Links**:
  - A hard link associates multiple filenames with the same block of data
  - Deleting the last hard link results in the removal of that data. Otherwise,the link "keeps it"
- **Soft links**:
  - A symlink acts like a shortcut, pointing to another file
  - Deleting a symlink does not affect its target file.

#### Sockets

Sockets are special files that facilitate communication between different processes.

#### Named Pipes

Also known as FIFOs, these files allow one process to deliver its output directly to another using a unidirectional data flow.
