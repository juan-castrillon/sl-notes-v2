---
title: "Vim"
date: 2025-06-15T17:08:25+02:00
draft: false
---

Vim (Vi IMproved) is a powerful, modal text editor commonly found on Unix-like systems. Unlike most text editors, Vim operates in different **modes**, each optimized for a specific type of interaction—editing, navigating, or executing commands. 


## The Three Primary Modes

Vim operates in three core modes:

### 1. **Normal Mode (Command Mode)**
This is the default mode when opening a file. In this mode, text is not directly inserted. Instead, keystrokes are interpreted as commands for navigating, copying, deleting, or manipulating text.

Some commands in this mode include:

| Command    | Description                                    |
| ---------- | ---------------------------------------------- |
| `yy`       | Copy (yank) the current line                   |
| `dd`       | Delete (cut) the current line                  |
| `3dd`      | Delete 3 lines starting from the current       |
| `p`        | Paste after the current line or cursor         |
| `x`        | Delete the character under the cursor          |
| `u`        | Undo the last change                           |
| `Ctrl + r` | Redo the last undone change                    |
| `/pattern` | Search **downward** for a pattern              |
| `?pattern` | Search **upward** for a pattern                |
| `n`        | Next - Repeat the last search (same direction) |
| `N`        | Previous - Repeat in the opposite direction    |


### 2. **Insert Mode**
In Insert mode, typed characters are inserted into the buffer as text.

All of the following commands can be used to switch from normal mode to insert mode:

| Command | Description                       |
| ------- | --------------------------------- |
| `i`     | Insert before the cursor          |
| `I`     | Insert at the beginning of line   |
| `a`     | Append after the cursor           |
| `A`     | Append at the end of the line     |
| `o`     | Open a new line below the current |
| `O`     | Open a new line above the current |

To return to Normal Mode, press `Esc`.


### 3. **Last Line Mode (Command-Line Mode)**

Accessed by typing `:` from Normal Mode, this mode allows file-level operations and configuration commands.

Some commands include

| Command | Description           |
| ------- | --------------------- |
| `:w`    | Save (write) the file |
| `:q`    | Quit                  |
| `:wq`   | Save and quit         |
| `:q!`   | Quit without saving   |

To return to Normal Mode, press `Esc`.