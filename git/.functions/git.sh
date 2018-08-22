git-g-alias() {
    if [[  $# -eq 0 ]]; then
      git-status-log-recent
    else
      git $*
    fi
}

export GIT_LOG_MY_FORMAT='%C(auto,yellow)%h - %C(auto,blue)%>(14,trunc)%cd - %C(reset)%s%C(auto,cyan)% gD% %C(reset)'
export GIT_LOG_MY_FORMAT_LONG_DATE='%C(auto,yellow)%h - %C(auto,cyan) %cd %C(auto,reset) - %s%C(auto,cyan)% gD% %C(reset)'
export GIT_LOG_MY_FORMAT_GRAPH='%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s'
git-log-recent() {  git --no-pager log --pretty=format:"$GIT_LOG_MY_FORMAT" --abbrev-commit --date=relative "-$1" ; }
git-log-date() { git --no-pager log --pretty=format:"$GIT_LOG_MY_FORMAT_LONG_DATE" --abbrev-commit --date=format:'%Y-%m-%d %a %H:%M:%S' "-$1" ; } 
git-log-tree() { git log --graph --full-history --all --color --pretty=format:"$GIT_LOG_MY_FORMAT_GRAPH" ; }

git-status() { git status -s ; }
git-status-log-recent() {git-status ; emptyLine ; git-log-recent 10}

git-push() { git push $* && git-status-log-recent ; }

git-commit-better() { git commit -v $* && git-status-log-recent ; }
git-commit-amend() { git commit -v --amend && git-status-log-recent ; }
git-commit-message() { git commit -vm $* && git-status-log-recent ; }

git-add-status() { git add $* && git-status-log-recent ; }
git-add-commit() { git add $1 && git-commit-better $* ; }
git-add-commit-message() { git add $1 && git-commit-message $* ; }
git-add-commit-amend() { git add $1 && git-commit-amend ; }
git-add-all-commit() {  git add -A && git-commit-better $* }
git-add-all-commit-message() {  git add -A && git-commit-message $* }
git-add-all-commit-amend() {  git add -A && git-commit-amend }
git-add-update-commit() {  git add -u && git-commit-better $* }
git-add-update-commit-message() {  git add -u && git-commit-message $* }
git-add-update-commit-amend() {  git add -u && git-commit-amend }

# From oh-my-zsh
# Used also in prompt
function git-get-current-branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}