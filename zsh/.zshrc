# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt appendhistory
setopt histignorealldups
setopt sharehistory
setopt autocd
setopt beep
setopt extendedglob
setopt nomatch
setopt notify
setopt nocompletealiases
setopt promptsubst

# vim style keybindings
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/soma/.zshrc'

autoload -U compinit && compinit
autoload -U colors && colors

current_branch() {
    if [[ -d .git ]]; then
        echo "($(git rev-parse --abbrev-ref HEAD))"
    fi
}

###---- Command prompt ----###
LPROMPT () {
    PS1='┌─[%{$fg[red]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}$(current_branch)%{$reset_color%}]
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


###---- Keybindings ---###
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^R" history-incremental-search-backward


###---- Aliases ---###
# generel aliases
alias ...='cd ../../'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias pong='ping -c3 www.google.com'

# git aliases
alias gps='git push'
alias gpso='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull --ff-only --rebase'
alias gst='git status'
alias gft='git fetch'
alias gcm='git commit'
alias gmg='git merge'
alias gaa='git add -A'
alias gad='git add'
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
alias pacins='sudo pacman -S'
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
