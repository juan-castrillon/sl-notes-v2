---
title: "Diffs"
date: 2022-12-27T18:15:21+01:00
draft: true
---

## What is a diff?

A diff is the output of using the `git diff` command. Is a text that allows to view differences or changes between commits, branches, files, working directory and many other things. 

Example:
```diff
diff --git a/rainbow.txt b/rainbow.txt
index 0b75516..26ec8e7 100644
--- a/rainbow.txt
+++ b/rainbow.txt
@@ -3,4 +3,5 @@ orange
 yellow
 green
 blue
-purple
+indigo
+violet
```

## How to read a diff

Here are the more meaningful lines in the example below:

- The first line shows which two files are being compared. Is normally the same file but can be set up to be different. Original is going to be A and new is B

```diff
diff --git a/rainbow.txt b/rainbow.txt
```

- `-` will be used for representing changes in file a, and `+` for changes in file b

```diff
--- a/rainbow.txt
+++ b/rainbow.txt
```

- Next the chunks will start. A diff will only show portions or chunks of files that were modified together with some context (lines before and after). The first thing is the header. In this case it means: From file a, 4 lines are extracted starting from line 3 (in the chunk) and from file b, 5 lines are extracted starting from line 3 (in the chunk)

```diff
@@ -3,4 +3,5 @@ orange
```

- Finally, the changes are shown with the symbols relating to the files as explained above

```diff
 yellow
 green
 blue
-purple
+indigo
+violet
```

In this case, in file A, the last line was `purple`. Meanwhile in file B, `purple` was removed and `indigo` and `violet` were added


## How to create a diff

There a different ways to run the `git diff` command according to what you want to compare:

- `git diff` will show changes in the working directory that are not in staging yet. In other words, compares the working directory with the staging area

- `git diff HEAD` will compare HEAD and the working directory. In other words, it shows changes in the working directory since the last commit. Different to above it will show staged and unstaged changes.

- `git diff --staged` or `git diff --cached` will compare HEAD and the staging area. It will show the changes that will be committed.

It is also possible to combine this options with different targets:

- `git diff <OPS> file` shows changes for a specific file

- `git diff <OPS> branch1..branch2` or `git diff <OPS> branch1 branch2` will compare two branches. The order in which they are passed determines which is considered A and B (First is always the "base"). In addition, adding a file name at the end, will limit the comparison to a specific file

- `git diff commit1..commit2` will compare changes between two commits, passing the hash of the commits. Same as above, the order influences which is A and B.