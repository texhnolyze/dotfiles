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
# copy to cliboard on vim mode yank
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | xclip -i
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

autoload -U colors && colors


###---- Color utils ----###
export GREP_COLORS="mt=1;31"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# colors for ls
if [[ -f /tmp/.dir_colors ]]; then
  source /tmp/.dir_colors
elif type vivid &> /dev/null; then
  VIVID_THEME="solarized-dark"
  echo -e "LS_COLORS='$(vivid generate "$VIVID_THEME")'\nexport LS_COLORS" > /tmp/.dir_colors
  source /tmp/.dir_colors
elif [[ -f ~/.dir_colors ]]; then
  source ~/.dir_colors
fi

function in_container() {
  [[ -n "$DOCKER" ]] && echo "docker "
}

function in_virtualenv() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        local venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo " $venv"

    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
      echo " $CONDA_DEFAULT_ENV"
    fi
}

###---- Command prompt ----###
PROMPT='┌─[%{$fg[green]%}$(in_container)%{$fg[red]%}%m%{$fg_bold[white]%}$(in_virtualenv)%}%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}$(git_current_branch_for_prompt)%{$reset_color%}]
└─── '


###---- Aliases ---###
# generel aliases
alias _='sudo'
alias ...='cd ../../'
alias ls='ls --color=auto'
alias ll='ls -lha'
alias mk='mkdir -p'
alias grep='grep --color=auto'
alias pong='ping -c3 www.google.com'
alias cpv='rsync -aAXbP -hhh --backup-dir=/tmp/rsync -e /dev/null'
export RSYNC_COMPRESSION_EXCLUDES="3fr/3g2/3gp/3gpp/7z/aac/ace/amr/apk/appx/appxbundle/arc/arj/arw/asf/avi/bz/bz2/cab/cr2/crypt[5678]/dat/dcr/deb/dmg/drc/ear/erf/flac/flv/gif/gpg/gz/iiq/jar/jp2/jpeg/jpg/h26[45]/k25/kdc/kgb/lha/lz/lzma/lzo/lzx/m4[apv]/mef/mkv/mos/mov/mp[34]/mpeg/mp[gv]/msi/nef/oga/ogg/ogv/opus/orf/pak/pef/png/qt/rar/r[0-9][0-9]/rz/rpm/rw2/rzip/sfark/sfx/s7z/sr2/srf/svgz/t[gb]z/tlz/txz/vob/wim/wma/wmv/xz/zip"
alias rsync='rsync --skip-compress=$RSYNC_COMPRESSION_EXCLUDES'
alias sshpw='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no -CY'
alias socks='ssh -D 1337 -q -C -N'
alias cl='curl -fsSL'
alias nmapssh='sudo nmap -sS -p 22'
alias tex='mkdir -p output && xelatex -output-directory=output'

# coding aliases
alias rspec='rspec --color --format documentation'
alias phpunit='phpunit --colors --verbose'
alias c='cargo'
alias cr='cargo run'
alias cb='cargo build'

function venv() {
  venv_dirs="$(find ~/.virtualenvs/* -maxdepth 0 -type d,l -print)"
  chosen_venv="$(echo "$venv_dirs" | fzf)"
  source "$chosen_venv/bin/activate"
}

# systemd aliases
alias sstart='systemctl restart'
alias sstop='systemctl stop'
alias sstat='systemctl status'
alias senab='systemctl enable'
alias sdisab='systemctl disable'
alias journ='journalctl -xe -b'

# docker/kubernetes aliases
alias d='docker'
alias dc='docker-compose'
alias mk='minikube'
alias helm='helm-tls-wrapper'
alias h='helm-tls-wrapper'

# vagrant aliases
alias v='vagrant'
alias vu='vagrant up'
alias vp='vagrant provision'
alias vs='vagrant ssh'
alias vd='vagrant destroy'
alias vn='vagrant destroy && vagrant up'

# utitlity aliases
alias slideshow='feh -rzZFD 5'
alias dirsizes='du -hd1 | sort -h'
alias mpv='mpv --save-position-on-quit'
alias t='trans'
alias ted='trans -t de'
alias tde='trans -l de'
alias dl='aria2c -c -j 5 -x 10 -s 10 -k 1M'
alias ytdl='yt-dlp --downloader aria2c --downloader-args aria2c:"-c -j 5 -x 10 -s 10 -k 1M"'

###---- Extensions ----###
# fnm nodejs version manager setup
if type fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

# search history with fzf if installed, default otherwise
if [[ -d /usr/share/fzf ]]; then
  source /usr/share/fzf/completion.zsh
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

# add custom completions folder
fpath+=~/.zfunc
# enable completions zsh/bash completions
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

###---- Plugins ---###
source ~/.zsh_plugins/package-manager.plugin.zsh

if type git &> /dev/null; then
  source ~/.zsh_plugins/git.plugin.zsh

  # fzf plugin is dependent on git plugin
  if type fzf &> /dev/null; then
    source ~/.zsh_plugins/fzf.plugin.zsh
  fi
fi

if type gradle &> /dev/null; then
  source ~/.zsh_plugins/gradle.plugin.zsh
fi

if type dotnet &> /dev/null; then
  source ~/.zsh_plugins/dotnet.plugin.zsh
fi

if [[ -d /opt/ros ]]; then
  source ~/.zsh_plugins/ros.plugin.zsh
fi

additional_completions=( kind k3d kyma )
for tool in "${additional_completions[@]}"; do
  if type $tool &> /dev/null; then
    source <($tool completion zsh)
  fi
done

if type zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi
