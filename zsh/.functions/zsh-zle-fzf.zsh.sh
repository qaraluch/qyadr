# ZSH terminal helpers and utils functions with help of fzf
# dependencies:
# fzf
# git

function fzf-choose-git-msg () {
 echo "\"$( git-get-logs | fzf | cut -d " " -f2-)\""              # see: git/.functions/git.sh
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
