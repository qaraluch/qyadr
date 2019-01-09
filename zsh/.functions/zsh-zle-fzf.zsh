# ZSH terminal helpers and utils functions with help of fzf
# dependencies:
#  - fzf
#  - git

# GIT
fzf-choose-git-msg() {
 echo "\"$( git-get-logs | fzf --layout=reverse --border | cut -d " " -f2-)\""                                    # see: git/.functions/git.sh
      # ^- add quotations to git msg
}

zle-fzf-git-get-commit-msg() {
  if git-is-in-repo ; then	                               # see: git/.functions/git.sh
    _zle-init-widget                                       # see: zsh/.functions/zsh-zle.zsh
    fzf-choose-git-msg | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}

zle -N gmsg zle-fzf-git-get-commit-msg                      # usage: in vi mode: hit <esc>, :, and type gmsg

fzf-choose-git-hash() {                                     # see: git/.functions/git.sh
  echo "$( git-get-logs | \
    fzf --height 60% --layout=reverse --border | \
    cut -d " " -f1
  )"
}

zle-fzf-git-get-hash () {
  if git-is-in-repo ; then
    _zle-init-widget                                        # see: zsh/.functions/zsh-zle.zsh
    fzf-choose-git-hash | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}

zle -N ghash zle-fzf-git-get-hash

fzf-choose-git-status-item() {                              # see: git/.functions/git.sh
  echo "$( git-get-status-items | \
    fzf --height 40% --layout=reverse --border -m | \
    awk '{print $2}'
  )"
}

zle-fzf-git-get-status-item() {
  if git-is-in-repo ; then
    _zle-init-widget                                        # see: zsh/.functions/zsh-zle.zsh
    fzf-choose-git-status-item | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}

zle -N gadd zle-fzf-git-get-status-item

# LOCATE
fzf-choose-locate-item() {
  echo "$( locate-get-data | \
    fzf --height 40% --layout=reverse --border -m
  )"
}

zle-fzf-locate-item() {
  _zle-init-widget                                        # see: zsh/.functions/zsh-zle.zsh
  fzf-choose-locate-item | \
  _zle-insert
}

zle -N zle-fzf-locate-item