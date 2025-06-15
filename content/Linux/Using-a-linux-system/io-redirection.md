---
title: "I/O Redirection"
date: 2023-01-14T11:35:55+01:00
draft: false
---

In Linux, every process that runs in a shell interacts with three essential data streams: input, output, and error. These streams are the foundation of **I/O redirection**, which allows control over how data flows into and out of commands. 

## The Three Standard Streams

Linux associates three **standard streams** with every process:

### 1. **Standard Input (STDIN)** – File Descriptor `0`
STDIN is the source of input data for commands. By default, this comes from the keyboard. For example, running `cat` without any arguments reads from STDIN.

```bash
cat
```
Typing text followed by `Ctrl+D` (end-of-file) will send input to the command.

### 2. **Standard Output (STDOUT)** – File Descriptor `1`
STDOUT is where a command sends its regular output. By default, this is displayed on the terminal screen.

Example:
```bash
echo "Hello"
```
prints "Hello" to STDOUT.

### 3. **Standard Error (STDERR)** – File Descriptor `2`
STDERR is used exclusively for error messages or diagnostics, separate from STDOUT. This ensures that errors do not get mixed with regular output unless explicitly redirected.

Example:
```bash
ls non_existing_file
```
generates an error message sent to STDERR.



## Redirection Operators

Redirection changes the default flow of these streams.

| Operator                      | Meaning                                             |
| ----------------------------- | --------------------------------------------------- |
| `< file`                      | Redirect STDIN from a file                          |
| `> file`                      | Redirect STDOUT to a file (overwrite)               |
| `>> file`                     | Append STDOUT to a file                             |
| `2> file`                     | Redirect STDERR to a file                           |
| `2>> file`                    | Append STDERR to a file                             |
| `2>&1`                        | Redirect STDERR to the same place as STDOUT         |
| `&> file` or `>& file` (Bash) | Redirect both STDOUT and STDERR to a file           |
| `2> /dev/null`                | Discard error messages (send STDERR to null device) |

Examples:

```bash
command > output.txt            # STDOUT to file
command 2> errors.txt           # STDERR to file
command > out.txt 2>&1          # Both to same file
```


## Pipes: Chaining Commands

A **pipe** (`|`) connects the STDOUT of one command directly to the STDIN of another, enabling powerful command chains.

```bash
cat file.txt | grep "pattern"
```

This setup sends the contents of `file.txt` to `grep`, which searches for lines matching "pattern".


## Useful Tools and Tricks

### Using `tee` to Save and Display Output

The `tee` command reads from STDIN and writes to both STDOUT and a file:

```bash
echo "Log entry" | tee logfile.txt
```

This prints "Log entry" to the terminal and saves it in `logfile.txt`.

Add `-a` to append:

```bash
command | tee -a logfile.txt
```

---

### Here Documents (`<<`) and Here Strings (`<<<`)

**Here documents** allow multi-line input directly in the shell:

```bash
cat << EOF
This is
multi-line input
EOF
```

**Here strings** provide a single-line string as STDIN:

```bash
cat <<< "This is a single line"
```

These are especially useful in scripts to feed blocks of text to commands.
