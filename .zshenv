typeset -U path
path=($(ruby -e 'print Gem.user_dir')/bin $HOME/bin $HOME/.composer/vendor/bin $path)
export EDITOR="vim"
