RELEASE_DISTRIBUTOR="$(lsb_release -i)"

arch_linux_aliases() {
  if type yay &> /dev/null; then
    alias pacupg='yay'
    alias pacins='yay -S'
    alias pacdel='yay -Rns'
    alias pacsearch='yay -Ss'
  else
    alias pacupg='sudo pacman -Syu'
    alias pacins='sudo pacman -S'
    alias pacdel='sudo pacman -Rns'
    alias pacsearch='sudo pacman -Ss'
  fi

  alias pacquery='sudo pacman -Q'
  alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
}

debian_based_aliases() {
  alias pacupg='sudo apt update && sudo apt upgrade'
  alias pacins='sudo apt install'
  alias pacsearch='apt search'
  alias pacdel='sudo apt purge'
  alias pacquery='apt show'
}

if [[ $RELEASE_DISTRIBUTOR =~ "Arch" ]]; then
  arch_linux_aliases
fi

if [[ $RELEASE_DISTRIBUTOR =~ "Ubuntu|Debian" ]]; then
  debian_based_aliases
fi
