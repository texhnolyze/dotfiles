#!/bin/sh
if ! type antibody > /dev/null 2>&1; then
  install_antibody
fi

bundle_antibody

install_antibody() {
  if type yay > /dev/null 2>&1; then
    pacman -Q antibody || yay -S --needed --noconfirm antibody
  elif type dpkg > /dev/null 2>&1; then
    curl -sL https://github.com/getantibody/antibody/releases/download/v3.6.0/antibody_3.6.0_linux_amd64.deb /tmp/antibody.deb
    dpkg -i /tmp/antibody.deb
  else
    echo "none of the normal installation methods supported"
    echo "falling back to curl | sh -s"

    curl -sL https://git.io/antibody | sh -s
  fi
}

bundle_antibody() {
  antibody bundle < "$HOME/dotfiles/antibody/bundles.txt" > ~/.zsh_plugins.sh
  #antibody update
}
