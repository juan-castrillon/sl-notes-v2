---
title: "Branches"
date: 2022-12-24T11:35:22+01:00
draft: true
---

## What are branches?

In GIT each commit, identified by a unique hash, has a reference to its parent commit

![com](/images/Git/commit.png)

Branches can be tought of as alernate timelines in a project. They exist at the same time but are completely different contexts, so changes in a branch dont affect other branches.

In detail, branching happens when a commit has more that one child commit. In a techinical manner, branches are a reference to a commit (that has a series of parent commits) like shown below:

![b1](/images/Git/branch1.png)

## HEAD pointer

- Points to the current location in the repository ( a branch reference )
- The branch reference is just the reference to the last commit

## Commands for branching

### `git branch`
- Shows all local branches of a repository. `git branch -r` will show remote branches and `git branch -a` will show all of them.
- If used with a name (`git branch name`) it will create (but not switch) a new branch based on the current HEAD.
- With the `-d` flag, it can be used to delete branches. (`-D` to force delete)
- The `git branch -m new_name` will change the name of the current branch (current HEAD)

### `git switch`
- Allows to switch between existing branches
- `git switch -c name` can be used to create a new branch and switch to it

### `git checkout`
- Allows to switch between existing branches
- Older command with lots of extra functionalities
- `git checkout -b name` can be used to create a new branch and switch to it

{{< tip "warning" >}}
Uncommited changes will be lost if switching branches (can be stashed). Only if the changes do not conflict, for example new files that dont exist, will these come to the new branch
{{< /tip >}}

## Merging branches