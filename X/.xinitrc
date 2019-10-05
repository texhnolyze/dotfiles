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
type syndaemon &>/dev/null && syndaemon -d -t -k -i 2

# use gnome as default X session
session=${1:-gnome}

case $session in
  bspwm             )
    # set up virtual window manager
    # for java gui compatibility
    wmname LG3D

    # run bspwm and it's keybinding manager
    sxhkd &
    exec bspwm;;
  dwm               )
    # set up virtual window manager
    # for java gui compatibility
    wmname LG3D

    # run dwm tiling wm startup script
    sh ~/dotfiles/bin/dwm-start;;
  kde               ) exec startkde;;
  xfce|xfce4        ) exec startxfce4;;
  gnome|gnome3      )
    export XDG_SESSION_TYPE=x11
    export GDK_BACKEND=x11
    exec gnome-session;;
  # No known session, try to run it as command
  *                 ) exec $1;;
esac
