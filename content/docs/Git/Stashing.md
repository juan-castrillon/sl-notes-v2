---
title: "Stashing"
date: 2022-12-31T17:25:45+01:00
draft: true
---

## What is stashing?

`git stash` temporarily shelves (or stashes) changes made in a branch, that are not yet commited. This ways, you can store the changes without making a commit and switch context (or branch) to work on something else. 

It avoids conflicts and taking changes with you when you switch branches

## How to work with stash?

The git stash works like a traditional stack. This means is a LIFO data structure in which data can be pushed or popped. In this case, data being the changes made. 

### `git stash save`

- Save uncommitted changes (staged and unstaged) into the stash
- Also works with `git stash`

### `git stash pop`

- Get the top of the stack (most recent stashed changes) and apply them to the working directory
- Removes the changes from the stash

### `git stash apply`

- Similar to `pop` but does not remove it from stash
- Useful to apply changes in multiple places

### `git stash list`

- When calling `git stash` multiple times, all changes go the the stack
- `git stash list` shows all stashes and the last commit when they were saved
- If the changes were saved with `git stash save "message"`,it will also show the message.
- One can also apply or pop a particular stash with `git stash apply stash@{2}`
- A particular stash can also be dropped with `git stash drop stash@{2}`
- `git stash clear` drops all stashes