# ZSH terminal helpers and utils functions with help of fzf
# dependencies:
# fzf
# git

# run fzf with specific options
function fzf-reverse-full () {
  cat | fzf --layout=reverse --border 
}

function fzf-reverse-medium () {
  cat | fzf --height 60% --layout=reverse --border 
}

function fzf-choose-git-msg () {
 echo "\"$( git-get-logs | fzf-reverse-full | cut -d " " -f2-)\""              # see: git/.functions/git.sh
}

function zle-fzf-git-get-commit-msg {
  if git-is-in-repo ; then
    _zle-init-widget
    fzf-choose-git-msg | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"           
  fi
}

zle -N gmsg zle-fzf-git-get-commit-msg                      # usage: in vi mode: hit <esc>, :, and type gmsg
                                                            # or use alias "zle -A zle-fzf-git-get-commit-msg gmsg"
function fzf-choose-git-hash () {
  echo "$( git-get-logs | fzf-reverse-medium | cut -d " " -f1)"              # see: git/.functions/git.sh
}

function zle-fzf-git-get-hash {
  if git-is-in-repo ; then
    _zle-init-widget
    fzf-choose-git-hash | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"           
  fi
}

zle -N ghash zle-fzf-git-get-hash                      # usage: in vi mode: hit <esc>, :, and type gmsg