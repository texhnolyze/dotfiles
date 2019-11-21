#!/bin/zsh

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# adds history incrementally and share it across sessions
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# add timestamps to history
setopt EXTENDED_HISTORY

# don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY

setopt AUTO_CD
setopt BEEP
setopt EXTENDED_GLOB
setopt NO_MATCH
setopt NOTIFY
setopt NO_COMPLETE_ALIASES
setopt PROMPT_SUBST

# enable correction for mispelling
setopt CORRECT_ALL

# vim style keybindings
bindkey -v
# don't take 0.4s to vim modes
export KEYTIMEOUT=1

autoload -U colors && colors

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --short --quiet HEAD 2> /dev/null)

  local exit_code=$?
  if [[ $exit_code != 0 ]]; then
    [[ $exit_code == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null) || return
  fi

  echo "($ref)"
}

###---- Command prompt ----###
LPROMPT () {
  PS1='┌─[%{$fg[red]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}$(git_current_branch)%{$reset_color%}]
└─── '
}

LPROMPT


###---- Color utils ----###
export GREP_COLOR="1;31"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# colors for ls
if [[ -f ~/.dir_colors ]]; then
  eval $(dircolors -b ~/.dir_colors)
fi


###---- Aliases ---###
# generel aliases
alias _='sudo'
alias ...='cd ../../'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias pong='ping -c3 www.google.com'
alias cpv='rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress'

# git aliases
alias gps='git push'
alias gpso='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull --ff-only --rebase'
alias gst='git status'
alias gft='git fetch'
alias gcm='git commit'
alias gmg='git merge'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gau='git add -u'
alias grm='git rm'
alias gco='git checkout'
alias gcb='git checkout -b '
alias gcp='git cherry-pick'
alias gsta='git stash'
alias gstas='git stash save'
alias gstaa='git stash apply'
alias grb='git rebase'
alias grbo='git rebase --onto'
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar) %C(white)%s%C(red) - %an%C(reset)%C(bold yellow)%d%C(reset)'"

# coding aliases
alias g='gradle'
alias rspec='rspec --color --format documentation'
alias phpunit='phpunit --colors --verbose'
alias c='cargo'
alias cr='cargo run'
alias cb='cargo build'

# pacman/yay aliases
alias pacupg='yay'
alias pacins='yay -S'
alias pacdel='yay -Rns'
alias pacquery='sudo pacman -Q'
alias pacsearch='yay -Ss'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'

# apt aliases
alias aptins='sudo apt install'
alias aptsearch='apt search'
alias aptdel='sudo apt purge'
alias aptquery='apt show'
alias aptupg='sudo apt update && sudo apt upgrade'

# systemd aliases
alias sstart='systemctl restart'
alias sstop='systemctl stop'
alias sstat='systemctl status'
alias senab='systemctl enable'
alias sdisab='systemctl disable'
alias journ='journalctl -xe -b'

# docker aliases
alias d='docker'
alias pandoc='docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker'
alias eisvogel='docker run --rm -v `pwd`:/pandoc dalibo/pandocker --pdf-engine=xelatex --template=eisvogel'

# kubernetes aliases
alias mk='minikube'
alias helm='helm-tls-wrapper'
alias h='helm-tls-wrapper'

# utitlity aliases
alias slideshow='feh -rzZFD 5'
alias dirsizes='du -hd1 | sort -h'


###---- Extensions ----###
# search history with fzf if installed, default otherwise
if [[ -d /usr/share/fzf ]]; then
  source /usr/share/fzf/key-bindings.zsh
elif [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  bindkey '^R' history-incremental-search-backward
fi

# edit current command in EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^XE' edit-command-line
bindkey '^X^E' edit-command-line

if [[ -f ~/.zsh_plugins.sh ]]; then
  source ~/.zsh_plugins.sh

  # zsh-history-substring-search plugin keybindings
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  # zsh-aliases settings
  export ZSH_PLUGINS_ALIAS_TIPS_FORCE=1
  export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Use alias stupid: "
else
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# add custom completins folder to fpath
fpath+=($HOME/.zsh_functions)
# enable completions
autoload -U compinit && compinit

# apparently has to come after initalizing the completion otherwise
# there is a "complete:13: command not found: compdef" error
if type kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

if type minikube &> /dev/null; then
  source <(minikube completion zsh)
fi
