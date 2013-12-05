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

#loading and merging ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# start terminal emulation daemon
/usr/bin/urxvtd -q -o -f 

# set up wallpaper
sh ~/.fehbg &

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

#execute dwm startup script
sh ~/bin/startdwm
