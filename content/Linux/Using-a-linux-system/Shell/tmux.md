---
title: "Tmux"
draft: false
---

Tmux is an application that allows the creation of different terminals inside a single shell (terminal multiplexer). It provides several benefits like:

- Persistent SSH sessions: Specially practical when connecting to remote servers, `tmux` sessions will remain even if ssh connection is lost, as long as the machine is not turned off
- Terminal management: Sessions can have several windows (tabs) and each window supports several panes. THese split terminals can display information simultaneously and be "grouped" to execute the same command at the same time. 
- Allow programs running on a remote server to be accessed from multiple different local computers.


## Basic usage

Below are basic `tmux` actions:

```bash
tmux # Create new unnamed session
tmux new # Same
tmux new -s "name" #Create a new session named "name"
tmux ls #List sessions
tmux attach -t "name" #Attach to running session "name"
```

## `tmux` control mode

When invoking `tmux`, a new nameless session is created and a terminal is displayed. However any key typed will be thought of as part of the command for the terminal, not for tmux. For this, to control `tmux` one has to enter in control mode. Then `tmux` will be "listening" to keys for configurations.

In default installations the way to enter control mode is to type the "prefix key" which is <kbd>Ctrl</kbd> +  <kbd>b</kbd>

{{% notice style="warning" title="Attention" %}}
All commands shown below assume the default configuration but they can be customized
{{% /notice %}}


## Panes

Every terminal inside `tmux` belongs to one pane, this is a rectangular area which shows the content of the terminal inside `tmux`. Because each terminal inside `tmux` is shown in only one pane, the term pane can be used to mean all of the pane, the terminal and the program running inside it.

Each pane appears in one window. A window is made up of one or more panes which together cover its entire area. This means the windows can be "carved" into different panes:

![](/images/Linux/tmux_pane_diagram.png)

### Create new pane

A new pane is always created in reference of the current pane

Vertical split: <kbd>PREFIX</kbd> + <kbd>%</kbd> 
Horizontal split: <kbd>PREFIX</kbd> + <kbd>"</kbd> 

### Move between panes

Left: <kbd>PREFIX</kbd> + <kbd>&#8592;</kbd> 
Right: <kbd>PREFIX</kbd> + <kbd>&#8594;</kbd> 
Up: <kbd>PREFIX</kbd> + <kbd>&#8593;</kbd> 
Down: <kbd>PREFIX</kbd> + <kbd>&#8595;</kbd> 


### Close active pane

<kbd>PREFIX</kbd> + <kbd>x</kbd> 

## Windows

A window (or tab) is made up of one or more panes which together cover its entire area. Every window has a name - by default `tmux` will choose one but it can be changed by the user

Multiple windows are grouped together into sessions. Each window in a session has a number, called the window index. Even if the window is deleted, the index does not move. 

Each session has one current window, this is the window displayed when the session is attached and is the default window for any commands that target the session. If the current window is changed, the previous current window becomes known as the last window.

### Create new window

Either `tmux` can be called inside of `tmux`

```bash
tmux new-window
tmux new-window -n "name"
```

Or the keyboard can be used:

<kbd>PREFIX</kbd> + <kbd>c</kbd> 

### Rename window

Either

```bash
tmux rename-window name
```

or 

<kbd>PREFIX</kbd> + <kbd>,</kbd> and then type the name

### Move between windows

Go to next window (on the right): <kbd>PREFIX</kbd> + <kbd>n</kbd> 
Go to previous window (left): <kbd>PREFIX</kbd> + <kbd>p</kbd> 


### Close window

<kbd>PREFIX</kbd> + <kbd>&</kbd> 


## Sessions

Sessions group one or more windows together. They are the "bigger" block of `tmux` and allow organization between work processes. One can attach to different sessions. 

They are always named, but when no name is given in creation, `tmux` assigns one (normally a number)


### Create a new session

`tmux` can be called from outside `tmux` to create a new session

```bash
tmux
tmux new
tmux new -s name
```

### List sessions

```bash
tmux ls
```

### Attach/dettach to a session

```bash
tmux attach -t name
```

To detach:

<kbd>PREFIX</kbd> + <kbd>d</kbd> 

### Rename active session

Either

```bash
tmux rename-session name
```

or 

<kbd>PREFIX</kbd> + <kbd>$</kbd> 

### Switch sessions

<kbd>PREFIX</kbd> + <kbd>s</kbd> to go to an interactive selection menu


### Close session

To close the session, all windows must be closed. This can be done by typing `exit` in each pane, or by the commands seen above

## Customization

`tmux` is highly customizable. By defining a `~/.tmux.conf` file, one can set up different commands, key combinations and other behaviors. This file is read by `tmux` at initialization, and a re-read can be forced with `tmux source-file file`

{{% notice style="tip" %}}
ALl customizations can also be done "non-persistent" by typing <kbd>PREFIX</kbd> + <kbd>:</kbd> and then entering the command
{{% /notice %}}

### Example customization

The example below is inspired from [Learn Linux TV](https://www.learnlinux.tv/learn-tmux-part-5-how-to-customize-tmux-and-make-it-your-own/) shows pretty cool options. For complete documentation, here is the [config reference](https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux)

```conf
# Change prefix
set-option -g prefix C-j # Ctrl + j
set-option -g prefix2 C-f # Second prefix optional (Ctrl+f)
# Create new option (Prefix + r now reloads the config)
bind-key r sourcefile ~/.tmux.conf \; display-message "tmux.conf reloaded"
# Integrate mouse for changing terminals, adjusting sizes, etc. 
set -g mouse on
# Use Alt-arrow keys without prefix key to switch panes (No prefix)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
# Set easier window split keys
bind-key v split-window -h # Ctrl + v creates a vertical split
bind-key h split-window -v # Ctrl + h creates a horizontal split
# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window
# Synchronize panes (same command) with prefix+y (toggle)
bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."
```