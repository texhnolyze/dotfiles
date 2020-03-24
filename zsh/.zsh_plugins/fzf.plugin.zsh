### Functions for usage of fzf in combination with other tools like
### git, bat and others. Partly taken from
### https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
### Requires git.plugin.zsh

function fzf_down() {
  fzf --height 70% "$@" --border
}

function fzf_file_preview() {
  fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (bat --style=full --color=always {} ||
      highlight -O ansi -l {} ||
      coderay {} ||
      rougify {} ||
      cat {}) 2> /dev/null | head -500'
}

function fzf_git_files() {
  is_in_git_repo || return
  git -c color.status=always status --short \
    | fzf_down -m --ansi --nth 2..,.. \
      --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' \
    | cut -c4- \
    | sed 's/.* -> //'
}

function fzf_git_branches() {
  is_in_git_repo || return
  git branch -a --color=always \
    | grep -v '/HEAD\s' \
    | sort \
    | fzf_down --ansi \
      --multi \
      --tac \
      --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES \
    | sed 's/^..//' \
    | cut -d' ' -f1 \
    | sed 's#^remotes/##' \
    | sed 's#^origin/##'
}

function fzf_git_tags() {
  is_in_git_repo || return
  git tag --sort -version:refname \
    | fzf_down --multi \
      --preview-window right:70% \
      --preview 'git show --color=always {} | head -'$LINES
}

function fzf_git_hashes() {
  is_in_git_repo || return
  git_log_short_format \
    | fzf_down --ansi \
      --no-sort \
      --reverse \
      --multi \
      --bind 'ctrl-s:toggle-sort' \
      --header 'Press CTRL-S to toggle sort' \
      --preview-window right:45% \
      --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES \
    | grep -o "[a-f0-9]\{7,\}"
}

function fzf_git_remotes() {
  is_in_git_repo || return
  git remote -v \
    | awk '{print $1 "\t" $2}' \
    | uniq \
    | fzf_down --tac \
      --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' \
    | cut -d$'\t' -f1
}

# fzf aliases
alias f='fzf_file_preview'
alias fgb='fzf_git_branches'
alias fgt='fzf_git_tags'
alias fgf='fzf_git_files'
alias fgh='fzf_git_hashes'
alias fgr='fzf_git_remotes'

# fzf git aliases
alias gcob='git checkout $(fzf_git_branches)'
alias gcot='git checkout $(fzf_git_tags)'
alias gcoh='git checkout $(fzf_git_hashes)'

# fzf enviroment variables
if type fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
