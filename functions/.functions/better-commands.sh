mkdir-and-cd-better-command() {                        # from oh-my-zsh
    mkdir -p $@ && cd ${@:$#}
}

edit-zsh-history-in-editor() {
  _echoIt "$_QDel" "Let's edit .zsh-history in editor!"
  $EDITOR $HISTFILE
}

sort-zsh-history() {
  _echoIt "$_QDel" "Let's sort .zsh-history"
  fc -W # write history to file
  cp $HISTFILE "${HISTFILE}-backup"
  cat $HISTFILE | sort -u > "$HISTFILE-sorted"
  cp "$HISTFILE-sorted" $HISTFILE
  fc -R # read i.e load history form file
  if [[ "$1" == "-e" ]] ; then   # -e like edit
    edit-zsh-history-in-editor
  fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tree-better() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
tree-better-dirs() {
  tree -dC -a -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
    # -a show hidden dirs
}

rm-symlink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

path-print() {
  echo -e ${PATH//:/\\n}
}