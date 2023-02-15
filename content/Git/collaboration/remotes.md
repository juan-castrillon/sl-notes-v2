---
title: "Working with remotes"
date: 2023-02-02T18:37:18+01:00
draft: false
---

There are several repository management tools that allow to take the git workflow and ease collaboration based on the cloud. These are hosting platform for git repositories and their use is supported by native git commands. The most popular are:

- Github
- Gitlab
- Bitbucket


## Basic Worflow

When working with remotes there is 3 general operations performed:
1. Setup
2. Get data
3. Post data

When creating a new project or linking a local repo to the cloud for the first time, an empty remote should be created, after there is two options:
- If a local repo with data exist:  
  1. Add the remote
  2. Push the data

- If its a new project
  1. Clone the empty remote
  2. Do changes
  3. Push the data

### Setup

Any git repository can be configured with a remote. In order to get a list of the remotes of a repository,the following command is used

```sh
git remote -v
```

One (or more) can be added to the repository, renamed or deleted

#### Adding a remote

To add a remote the command is:

```sh
git remote add <name> <url>
```

Where: 
- `<name>` is the name to give the remote. In most cases, when adding the first remote this is called `origin` but is just a convention
- `<url>` is the HTTPS or SSH url of the repository in Github, gitlab, etc. 

{{% notice style="note" title="SSH Setup" %}}
In order to set up SSH Authentication, an SSH Key needs to be created and set up in the platform (github,gitlab, etc). This allows "password-less" flow which is way nicer than having to input the password every time a commit is pushed. 
{{% /notice %}}

{{% notice style="note" title="Main vs master" %}}
Gihub and gitlab among others are pushing for using the term `main` instead of `master` for the main branch of projects. In that sense, any new repo created will have the `main` branch if created with a file (for exaple a README). To adapt this, `git branch -M main` can be run to change the local `master` branch's name before pushing
{{% /notice %}}


#### Renaming a remote

The name of a remote can also be changed after creation with 

```sh
git remote rename <old> <new>
```

#### Deleting a remote

To delete a remote, the command is:

```sh
git remote remove <name>
```


### Getting Data

#### Cloning a remote

To "pull" a remote for the first time to a machine that does not have it, the `clone` command is used. 

```sh
git clone <url>
```

The command :
- Copies the data from the remote
- Initializes a local git repo. 
- Sets up remote tracking branch references pointing to the branches of the remote

{{% notice style="note" title="Remote tracking branches" %}}
These are a pointer (just like any other branch) to the latest commit of a branch in the remote. For example `origin/main` points to the last known commit of the `main` branch in the remote `origin`. To see all remote tracking branch references in a repo, the command `git branch -r` helps. Its also worth noting that they can be checkout with `git checkout origin/main` which will show the state of the `main` branch in [detached `HEAD` mode](../..//undo-changes/#detached-head)
{{% /notice %}}

##### Other branches

When cloning, only the default branch (`master` or `main`) is accessible in the local repository. This is because the cloning process, although it creates RTB references for all remote branches, just "links" the one of the default branch to a local branch.

In order to access other remote branches locally is enough to use

```bash
git switch <branch_name>
```

where `<branch_name>` is the same name as one of the remote branches. This will automatically:
- Create a new local branch called `<branch_name>`
- Link it with the RTB references for the remote branch


#### Fetching

`git fetch` allows to retrieve the latest changes from a remote repository without merging them into the local branch. 

The command can be used as `git fetch <remote>` to fetch all available changes (all branches) or `git fetch <remote> <branch>` to fetch a specific branch.

In more detail, it only updates the RTB references but not the local branches. So if running `git fetch origin master`, the `origin/master` reference will now point to the latest version, but the local `master` branch **won't** be affected. 

{{% notice style="tip" title="Seeing the changes" %}}
Once fetched, the changes can be seen with `git checkout` in detached HEAD mode
{{% /notice %}}



#### Pulling

`git pull` is similar to `git fetch`, but it also merges the changes from the remote repository into the local branch. This means that your local branch is automatically updated with the latest changes from the remote repository.

The command can be used like `git pull <remote> <branch>` to pull changes from a specific branch. In addition, `git pull` will default the remote to `origin` and the branch to the RTB reference linked to the current branch. 

In other words, it updates both the RTB reference (e.g. `origin/master`) and the current `HEAD` (e.g `master`)

Because of this, is **critical** to run the command in the correct place, as the current branch when the command is run will be the one updated. 


{{% notice style="warning" title="fetch vs pull" %}}
The main difference between `git fetch` and `git pull` is that `git fetch` only retrieves the changes from the remote repository, while `git pull` retrieves the changes and merges them into your local branch.
{{% /notice %}}


### Pushing data

In order to push or send local changes (commits) to the remote, the command `push` is used

```sh
git push <remote> <branch>
```

This command wil create a new branch on the remote (the first time) and push the changes on the local branch with the same name. For example `git push origin master` will push the changes from the local `master` branch to the remote `master` branch

To push to a branch with a different name, the whole syntax can be used:

```sh
git push <remote> <local_branch>:<remote_branch>
```

{{% notice style="tip" title="Upstream setup" %}}
If the `-u` is added to the `git push` command, the remote branch is set and remembered as the "upstream" for the local branch. This means that git will link the two of them, so next time just `git push` will work. 
{{% /notice %}}
