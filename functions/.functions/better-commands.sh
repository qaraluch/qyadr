mkdir-and-cd-better-command() {                        # from oh-my-zsh
    mkdir -p $@ && cd ${@:$#}
}

edit-zsh-history-in-editor() {
  _echoIt "$_QDel" "Let's edit .zsh-history in editor!"
  $EDITOR $HISTFILE
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tree-better() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
tree-better-dirs() {
  tree -dC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

pogoda() {
  local city="$1"
  local cityDefault='Gliwice'
  local apiUrl='http://wttr.in/'
  if [ -z "$city" ]; then
      city="${cityDefault}"
  fi
  local results=$(curl -s "${apiUrl}${city}")
  echo $results
}