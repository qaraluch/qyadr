export PATH=$HOME/.scripts:$PATH
for config (~/.functions/*.sh) source $config
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only