---
title: "Non categorized notes"
draft: true
---
        
# shell

Virtual terminals
One virtual terminal (usually VT 1 or VT 7) is reserved for the graphical environment, and text logins are enabled on the unused VTs. 
To switch between VTs, press CTRL-ALT-function key for the VT. For example, press CTRL-ALT-F6 for VT 6. Actually, you only have to press the ALT-F6 key combination if you are in a VT and want to switch to another VT.



# links

`ln f1 f2`  hard link f2 ->f1
`ln -s f1f2` soft

# VI

3 modes
    command
        move cursor
        `yy` copy a line
        `p` paste
        `ZZ`
        `x` delete letter
        `dd` delete line (cut)
        `d3d` delete 3 lines from the current
        `u` undo
        `ctrl` + `r` redo
        `/` search (from line downwards)
        `n` next
        `N` previous
        `?` search from line upwards (inverses n and N)
    insert
    last line
        save file `:w`
        discard `:q` (`:wq`)
            `:q!` quit dont save
        exit

open file -> command
command --`O,A,I,o,a,i`--> insert

insert --`esc`--> command
command --`:`--> last line
last line --`esc`--> command