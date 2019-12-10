### Helper functions for git usage and aliases for simplified access
### to most common git utilities, which are shorter than normal git
### aliases

function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function git_current_branch() {
  is_in_git_repo || return
  echo "$(git rev-parse --abbrev-ref HEAD)"
}

function git_current_branch_for_prompt() {
  is_in_git_repo || return
  echo "($(git_current_branch))"
}

function git_log_format() {
  git log --graph \
    --color=always \
    --date=relative \
    --abbrev-commit \
    --format="%C(bold blue)%h%C(reset) - %C(bold green)(%ar) %C(white)%s%C(reset) - %C(red)%an%C(reset)%C(bold yellow)%d%C(reset)"
}

function git_log_short_format() {
  git log --graph \
    --color=always \
    --date=short \
    --abbrev-commit \
    --format="%C(bold blue)%h%C(reset) -%C(bold yellow)%d %C(white)%s%C(reset) - %C(red)%an%C(reset)"
}

# git aliases
alias gps='git push'
alias gpso='git push -u origin $(git_current_branch)'
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
alias glg='git_log_format'
