---
title: "Undo Changes"
date: 2023-01-04T21:31:59+01:00
draft: true
---

Git offers different commands that allow to "travel back in time" or undo changes


## `git checkout`

### Detached HEAD

Using `git checkout <COMMIT>` leads to Detached HEAD state. 

This state, refers to when HEAD, instead of pointing to a branch reference (like usually) points to a specific commit. 

This state is useful for: 

- Looking around the state of a repo
- Make experimental changes
    - They can be committed and discarded just by switching to a branch
    - They can be kept if creating a new branch from the detached HEAD

The last option, allows to branch out on a particular commit in the repo history by reattaching the HEAD

<!-- tip -->
Commits can also be referenced from `HEAD` instead of the commit hash. So `git checkout HEAD~1` takes HEAD back one commit, and so on. 
<!-- tip -->

### Discard changes

`git checkout HEAD <files>` will revert all files to the HEAD (To the last commit made). Another way to do the same thing is `git checkout -- <files>`


## `git restore`

This new command was introduce to limit the wide functionality of `git checkout`. It can do two things:

### Discard changes

Same functionality as `git checkout HEAD <files>` is achieved with 

```sh
git restore <files>
```

<!-- tip -->
Restore also allows to set up a "source" different than HEAD to restore files like `git restore --source HEAD~1 <files>`
<!-- tip -->

### Unstage files 

To remove a file from the staging area and take it back to the working directory:
```sh
git restore --staged <file>
```