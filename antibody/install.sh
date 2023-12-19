#!/bin/bash

install_antibody() {
  if type yay &> /dev/null; then
    pacman -Q antibody || yay -S --needed --noconfirm antibody
  elif type dpkg &> /dev/null; then
    local dpkg_download_url="$(curl -fsSL \
      'https://api.github.com/repos/getantibody/antibody/releases/latest' \
      | jq '.assets[] | select(.name | contains("amd64.deb")) | .browser_download_url'\
    )"
    echo "$dpkg_download_url"
    curl -fsSL -o /tmp/antibody.deb "$dpkg_download_url"
    sudo dpkg -i /tmp/antibody.deb
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

if ! type antibody > /dev/null 2>&1; then
  install_antibody
fi

bundle_antibody
