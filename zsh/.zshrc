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
alias cpv=' rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress'

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
alias grm='git rm'
alias gco='git checkout'
alias gcb='git checkout -b '
alias gcp='git cherry-pick'
alias gsta='git stash'
alias gstas='git stash save'
alias grb='git rebase'
alias grbo='git rebase --onto'
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar) %C(white)%s%C(red) - %an%C(reset)%C(bold yellow)%d%C(reset)'"

# coding aliases
alias rspec='rspec --color --format documentation'
alias phpunit='phpunit --colors --verbose'

# pacman/yay aliases
alias pacupg='yay'
alias pacins='yay -S'
alias pacdel='yay -Rns'
alias pacquery='sudo pacman -Q'
alias pacsearch='yay -Ss'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'

# systemd aliases
alias sstart='systemctl restart'
alias sstop='systemctl stop'
alias sstat='systemctl status'
alias senab='systemctl status'
alias sdisab='systemctl status'
alias journ='journalctl -xe -b'

# utitlity aliases
alias slideshow='feh -rzZFD 5'
alias dirsizes='du -hd1 | sort -h'


###---- Extensions ----###
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ -f ~/.zsh_plugins.sh ]]; then
  source ~/.zsh_plugins.sh
fi

# enable completions
autoload -U compinit && compinit
