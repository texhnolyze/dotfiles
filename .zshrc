# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/soma/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# prompts
LPROMPT () {
	PS1="┌─[%{%}%m%{%} %~ %{%}%(0?..%?)%{%}]
└───╼ "
}

LPROMPT

# Aliases
alias pong='ping -c3 www.google.com'

# git aliases
alias gps='git push'
alias gpl='git pull'
alias gstat='git status'
alias gfetch='git fetch'

glg() {git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar) %C(white)%s%C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' $1}
