typeset -U path
path+=($(ruby -e 'print Gem.user_dir')/bin $HOME/bin $HOME/.composer/vendor/bin ./node_modules/.bin)

export EDITOR="vim"
export VAGRANT_DETECTED_OS="$(uname)"
