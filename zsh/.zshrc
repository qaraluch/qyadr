# vars
D_QYADR="${HOME}/.qyadr"                                      # dotfiles path 

export PATH=$HOME/.scripts:$PATH

for FILE ($HOME/.functions/*.sh) source $FILE
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only