export EDITOR="nvim"
export VAGRANT_DETECTED_OS="$(uname)"
export SSH_ASKPASS=ssh-askpass
export GOPATH="$HOME/coding/go"

typeset -U path
path+=(
  $HOME/bin
  $HOME/.local/bin
  $(ruby -e 'print Gem.user_dir')/bin
  $GOPATH/bin
  $HOME/.cargo/bin
  $HOME/.fnm
  $HOME/.yarn/bin
  ./node_modules/.bin
  ${KREW_ROOT:-$HOME/.krew}/bin
)

