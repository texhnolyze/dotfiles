# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory autocd beep extendedglob nomatch notify completealiases HIST_IGNORE_DUPS
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/soma/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors


###---- Command prompt ----###
LPROMPT () {
	PS1="┌─[%{$fg[red]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
└───╼ "
}

LPROMPT


###---- Colour utils ----###
export GREP_COLOR="1;31"
alias grep="grep --color=auto"
alias "ls=ls --color=auto"

# colors for ls
if [[ -f ~/.dir_colors ]]; then
    eval $(dircolors -b ~/.dir_colors)
fi


###---- Aliases ---###
# generel aliases
alias pong='ping -c3 www.google.com'

# git aliases
alias gps='git push'
alias gpl='git pull --ff-only'
alias gst='git status'
alias gft='git fetch'
alias gcm='git commit'
alias gaa='git add -A'
alias gad='git add'
alias gco='git checkout'
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar) %C(white)%s%C(red) - %an%C(reset)%C(bold yellow)%d%C(reset)'"

# coding aliases
alias rspec='rspec --color --format documentation'
alias phpunit='phpunit --colors --verbose'

# pacman aliases
alias pacupd='sudo pacman -Sy'
alias pacupg='sudo pacman -Syu'
alias pacins='sudo pacman -S'
alias pacquery='sudo pacman -Q'
alias pacsearch='sudo pacman -Ss'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
