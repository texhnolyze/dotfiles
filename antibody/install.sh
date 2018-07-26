#!/bin/sh
if type yay > /dev/null 2>&1; then
	yay -S --needed --noconfirm antibody
  antibody bundle < "$HOME/dotfiles/antibody/bundles.txt" > ~/.zsh_plugins.sh
  #antibody update
else
  echo "yay not available, antibody requires diffent way of install"
fi
