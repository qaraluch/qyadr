# Vars
export D_QYADR="${HOME}/.qyadr"                                      # dotfiles path, used in aliases 
export ZPLUG_HOME="${HOME}/.zplug"

export PATH=$HOME/.scripts:$PATH

# Sources
for FILE ($HOME/.functions/*.sh) source $FILE
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-install.zsh ] && source ~/.zsh-install.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only

# Plugins
if [[ -d "$ZPLUG_HOME" ]]; then
  source "${ZPLUG_HOME}/init.zsh"
fi

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'softmoth/zsh-vim-mode'

zplug load

