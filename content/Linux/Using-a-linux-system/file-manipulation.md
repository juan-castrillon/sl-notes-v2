---
title: "File Manipulation"
draft: false
---

As "everything in linux is a file", operations on files are critical to using a system:

## Seeing the content of files

Several tools exist to see the content of a file:

- `wc` is a utility that allows counting certain characters in a file

```bash
wc file1 # Print newline, word, and byte counts
wc -l file1 # Print number of lines
```

- `cat` is a multiuse utility that can be used to print the content of a file to stdout

```bash
cat file1 # Dump content into terminal
cat -n file1 # Dump content and add line numbers
tac file1 # Print content backwards (last line printed first)
```

- `head` and `tail` can be used to access only the beginning (or end) of a file. 

```bash
head file1 # Print first 10 lines
tail file1 # Print last 10 lines
head -5 file1 # Print first 5 lines
tail -n +5 # Print starting from line 5
tail -f file1 # Print last 10 lines and "follow" the file (monitor and print new lines)
```

- `less` is a pager utility to be able to scroll trough a file without a text editor

```bash
less file1
```

{{% notice style="note" title="Text editors" %}}
Of course, a text editor like `vim` or `nano` can also be used to see a file
{{% /notice %}}

## File compression and archive

Archiving is the operation of joining files into a single one (normally called a tarball). Although similar in paper, compression just means reducing the size by making use of compression algorithms. 

In linux, often the two operations are combined to form a compressed archive, which can then be shared easily

The main utility for this is `tar` (hence the name). This tool allows to archive but also directly compress archives using algorithms like:

- `gzip` (Good at compressing and fast)
- `bzip2` (Balance between compression and speed)
- `xz` (Powerful compression, slower)

```bash
tar -cf archive.tar files/ # Create an archive
tar -czf archive.tar.gz files/ # Create a compressed (gzip) archive 
tar -xzf archive.tar.gz # Extract files from a compressed archive
tar -tf archive.tar.gz # See files without extracting
```

When dealing with compressed files that are not archives, the algorithms can be used on their own:

```bash
gzip file # Compress a file, replacing it with file.gz
gzip -d file.gz # Decompress a file
bzip2
xz
```

Finally, `zcat` allows to show the content of compressed files without extracting them

```bash
zcat file.gz
```


## Searching for files

For searching files in the system, two possibilities exist:

- `locate` will find a file from a path database that registers all files in the system. This database is updated with the `updatedb` command

```bash
locate filename
```

- More powerful is the utility `find`. This is very flexible and allows the use of wildcards (see below), execution of code on found files, among others

```bash
find dir -name filename # Search filename recursively in dir/
find dir -iname filename # Case insensitive
find dir -type f # Find only files (d for directories, l for links)
find dir -name file* -exec rm -f {} ';' # Find all files that start with file and remove them
find dir -ctime 5 # Find all files whose metadata was changed 5 hours ago
find dir -atime +5 # Find all files who were last accessed more than 5 hours ago
find dir -mtime -5 # Find all file who were modified in the last 5 days
```

{{% notice style="info" title="`exec` parameter" %}}
To use the `exec` parameter, the command passed replaces the files with the placeholder `{}`. It also has to finish either with `';'` or `\;`
{{% /notice %}}


## Searching in files

The best utility for this is `grep`. It searches in each line using regular expressions (and wildcards). It is very powerful and can be used to find matches, find files that contain a match, etc.

```bash
grep "hello" file # Show all lines that contain hello
grep -i hello file # Case insensitive
grep -r hello dir/ #Search recursively in dir/
grep -v hello file # Show lines that dont contain hello
grep -w hello file # Show lines that contain the word hello (not helloworld for example)
grep -A 1 -B 1 hello file # Show matching lines, one after and one before
grep -rl hello dir/ # Print the file names that have at least one match
grep -P "(?<=h)ello" file # Use PERL regular expressions
```

{{% notice style="info" title="Wildcards" %}}
When passing filenames, one can use wildcards to pass multiple files as one:

| Wildcard | Matches                                            | Example                                       |
| -------- | -------------------------------------------------- | --------------------------------------------- |
| `?`      | Matches any single character                       | `hell?` will match hella, hellb, etc.         |
| `*`      | Matches any string of characters                   | `hell*` will match hella, hellaaaa,etc.       |
| `[set]`  | Matches any character in the set of characters     | [adf] will match any occurrence of a, d, or f |
| `[!set]` | Matches any character not in the set of characters | `hell[!o]` will not match hello               |
{{% /notice %}}