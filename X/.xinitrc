#!/bin/bash
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
[[ -f ~/.Xresources ]] && xrdb merge ~/.Xresources

# load X modified keymap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# setup xbindkeys keybindings for laptop
[[ -f ~/.xbindkeysrc ]] && xbindkeys

# start terminal emulation daemon
/usr/bin/urxvtd -q -o -f 

# set up wallpaper for window managers
sh ~/.fehbg &

# eanble syndaemon(no mouse clicks while typing) for notebook
syndaemon -d -t -k -i 2

if [[ "$1" = "awesome" ]]; then
    # set up virtual window manager 
    # for java gui compatibility
    wmname LG3D

    # run awesome tiling wm
    exec awesome
elif [[ "$1" = "dwm" ]]; then
    # set up virtual window manager 
    # for java gui compatibility
    wmname LG3D

    # run dwm tiling wm startup script
    sh ~/dotfiles/bin/dwm-start
elif [[ "$1" = "bspwm" ]]; then
    # set up virtual window manager 
    # for java gui compatibility
    wmname LG3D

    # run bspwm and it's keybinding manager
    sxhkd &
    exec bspwm
elif [[ "$1" = "sway" ]]; then
    # set up virtual window manager 
    # for java gui compatibility
    wmname LG3D

    # run sway wayland tiling wm
    exec sway
elif [[ "$1" = "xfce" ]]; then
    # run xfce4 session
    exec startxfce4
else
    # run gnome3 session
    exec gnome-session
fi
