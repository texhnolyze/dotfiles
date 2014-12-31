#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# virtualbox-guest-utils setup
#VBoxClient-all

# loading and merging ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# load X modified keymap
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

# start terminal emulation daemon
/usr/bin/urxvtd -q -o -f 

# set up wallpaper
sh ~/.fehbg &

# set up virtual window manager for VirtualMachines
#wmname LG3D

# run dwm window manager
#exec dwm

# run bspwm and it's keybinding manager
#sxhkd &
#exec bspwm

# execute dwm startup script
#sh ~/bin/startdwm
