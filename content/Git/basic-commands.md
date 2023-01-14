---
title: "Basic Commands"
date: 2022-12-22T16:07:48+01:00
draft: false
---

Below are some of the most used commands when using git from the command line: 

## `git init`

- Initializes a git repository in the current directory. This is done by creating a hidden `.git` directory.
- [Git docs](https://git-scm.com/docs/git-init)
- If used with a name as an argument like 
```bash
git init example
```
It will first create a folder called `example` and inside this folder initialize the repo.

{{% notice style="tip" title="Tip" %}}
To make a directory not a git repository anymore, just delete the hidden `.git` folder.
{{% /notice %}}


## `git status`

- Shows the current state of the files according to the basic workflow (un-tracked, staged).
- [Git docs](https://git-scm.com/docs/git-status)

## `git add`

- Normally used like `git add file` it adds a file to staging. This is done before committing because only staged files (or changes) are added to the commit.
 
- [Git docs](https://git-scm.com/docs/git-add)

If used like
```bash
git add -A
```
or 
```bash
git add .
```
Adds all the files that have been modified

## `git commit`

- Allows to create a commit for the staged changes. 
- [Git docs](https://git-scm.com/docs/git-commit)

To commit with a message directly:
```bash
git commit -m "message"
```

### Default editor
- If called without arguments, the command will prompt for a commit message using the default editor. 
- This can be changed with `git config --global core.editor`
- More info [here](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

## `git log`

Retrieves a complete list of commit history for the repo

- Its output can be compacted with the `--oneline` flag
- [Git docs](https://git-scm.com/docs/git-log)