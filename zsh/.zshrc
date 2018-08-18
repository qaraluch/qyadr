# vars
D_QYADR="${HOME}/.qyadr" 
# 
export PATH=$HOME/.scripts:$PATH
for fn (~/.functions/*.sh) source $fn
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only