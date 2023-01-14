---
title: "Git"
draft: false
---

# What is?

Git is a version control system. In other words it registers changes on a set of files. 

{{% notice style="tip" title="Good to know" %}}
Git uses SHA-1 to reference a version of a file or files.
{{% /notice %}}

 

## Basic Workflow

The basic workflow of Git is based on 3 states that files can be at:

1. The file (or files) are in the **working directory**, where they are modified
2. Changes (modified files) are added to the **staging area**
3. Staged changes are then **committed to the git repository**. This creates a version of the file (with an assigned SHA-1 id) called a commit.
