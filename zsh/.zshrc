# Vars
export D_QYADR="${HOME}/.qyadr"                                      # dotfiles path, used in aliases 
export D_PLUGS="${HOME}/.plugs"                                      

# Path
export PATH=$HOME/.scripts:$PATH

# Sources
for FILE ($HOME/.functions/*.sh) source $FILE
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only

# Plugs
# Create cache dir for plugins if not exists
if [[ ! -d "${D_PLUGS}-cache" ]]; then mkdir "${D_PLUGS}-cache" ; fi
for INSTALLATOR ($D_PLUGS/*.sh) source $INSTALLATOR