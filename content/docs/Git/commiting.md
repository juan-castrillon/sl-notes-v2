---
title: "Commiting"
date: 2022-12-22T22:02:23+01:00
draft: true
---

The key component of git is the commits. A commit is single point in the Git history; the entire history of a project is represented as a set of interrelated commits.

{{</* tip "warning" */>}}
By good practice, commits should be __atomic__. This means each commit should relate to only one feature. This makes it easier to control, and roll back.
{{</* /tip */>}}

## Commit Message

A commit contains the current contents of the index and the given log message describing the changes.

The commit message should follow:
- Is recommended by Git that the message is written in present tense + imperative
- Similar to giving orders to the machine
- Some examples:
    - `Fix bug in template code`
    - `Make script compatible with centos`

## Ammending

Ammending a commit replaces the tip of the current branch by creating a new commit that starts from the last one.

In practice it can be used to "fix" the last commit. 

{{< tip "warning" >}}
The changes to ammend need to be staged
{{< /tip >}}

## Ignoring files and directories

Files that should not bre tracked by git can be specified in a `.gitignore` file. 

The file supports files, directories and also glob expressions to match several files at the same time.

More information can be seen in the https://git-scm.com/docs/gitignore