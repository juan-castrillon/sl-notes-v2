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

Links make it possible to reference the same file content from different paths, which is useful for flexibility, backup strategies, and file management.

- **Hard Links**:
  - A hard link associates multiple filenames with the same block of data.
  - Both the original file and the hard link are indistinguishable at the filesystem level—they share the same **inode number**
  - Deleting one hard link does not remove the data **until** the last hard link is deleted.
  - Hard links **cannot** span across different filesystems or partitions.
  - Hard links **do not** work with directories (to prevent circular references).
  - Can be created with `ln f1 f2` (Link from f2 to f1)

- **Soft links**:
  - A symlink acts like a shortcut, pointing to another file
  - Deleting a symlink does not affect its target file.
  - If the target file is deleted or moved, the symlink becomes **broken** (dangling).
  - Modifying a symlinked file modifies the target file.
  - Symlinks **can** point across different filesystems.
  - Symlinks **can** refer to directories.
  - Can be created with `ln -s f1 f2` (Link from f2 to f1)


#### Sockets

Sockets are special files that facilitate communication between different processes.

#### Named Pipes

Also known as FIFOs, these files allow one process to deliver its output directly to another using a unidirectional data flow.
