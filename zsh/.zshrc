export PATH=$HOME/.scripts:$PATH
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
for config (~/.functions/*.{sh,zsh}) source $config