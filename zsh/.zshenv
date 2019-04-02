export EDITOR="nvim"
export TERM="rxvt-unicode-256color"
export VAGRANT_DETECTED_OS="$(uname)"
export SSH_ASKPASS=ssh-askpass
export GOPATH="$HOME/coding/go"

typeset -U path
path+=(
  $HOME/bin
  $(ruby -e 'print Gem.user_dir')/bin
  $GOPATH/bin
  ./node_modules/.bin
)

