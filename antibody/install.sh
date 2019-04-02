#!/bin/bash

install_antibody() {
  if test yay &> /dev/null; then
    pacman -Q antibody || yay -S --needed --noconfirm antibody
  elif test dpkg &> /dev/null; then
    local dpkg_download_url="$(curl -s https://api.github.com/repos/getantibody/antibody/releases/latest | jq '.assets[] | select(.name | contains("amd64.deb")) | .browser_download_url')"
    curl -sL "$dpkg_download_url" /tmp/antibody.deb
    dpkg -i /tmp/antibody.deb
  else
    echo "none of the normal installation methods supported"
    echo "falling back to curl | sh -s"

    curl -sL https://git.io/antibody | sh -s
  fi
}

bundle_antibody() {
  antibody bundle < "$HOME/dotfiles/antibody/bundles.txt" > ~/.zsh_plugins.sh
  antibody update
}

if ! test antibody &> /dev/null; then
  install_antibody
fi

bundle_antibody
