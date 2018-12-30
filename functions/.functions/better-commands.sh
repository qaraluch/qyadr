mkdir-and-cd-better-command() {                        # from oh-my-zsh
    mkdir -p $@ && cd ${@:$#}
}