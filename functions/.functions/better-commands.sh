mkdir-and-cd-better-command() {                        # from oh-my-zsh
    mkdir -p $@ && cd ${@:$#}
}

edit-zsh-history-in-editor() {
  _echoIt "$_QDel" "Let's edit .zsh-history in editor!"
  sleep 1
  $EDITOR $HISTFILE
}