ZSH_PROFILE='N'

# PROFILING
profileFor() { if [[ "$ZSH_PROFILE" == "Y" ]] ; then PROFILE_MSG=${1:-Run profile for sth...} ; _timer=$(($(date +%s%N)/1000000)) ; fi ; }
profileStop() { if [[ "$ZSH_PROFILE" == "Y" ]] ; then _now=$(($(date +%s%N)/1000000)) ; echo "[!] ---> elapsed: $(($_now-$_timer)) ms for: ${PROFILE_MSG}" ; fi ; }

# Vars
export D_QYADR="${HOME}/.qyadr"                                      # dotfiles path, used in aliases 
export D_PLUGS="${HOME}/.plugs"                                      

# Path
export PATH=$HOME/.scripts:$PATH

# Sources
profileFor 'all fns'
for FILE ($HOME/.functions/*.{sh,zsh}) source $FILE
profileStop

[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only

# Plugs
# Create cache dir for plugins if not exists
if [[ ! -d "${D_PLUGS}-cache" ]]; then mkdir "${D_PLUGS}-cache" ; fi

profileFor 'plugin - highlighting'
source $D_PLUGS/install-zsh-syntax-highlighting.sh
profileStop

profileFor 'plugin - vimto'
source $D_PLUGS/install-zsh-vimto.sh
profileStop

profileFor 'plugin - suggestions'
source $D_PLUGS/install-zsh-autosuggestions.sh
profileStop

profileFor 'plugin - fzf'
source $D_PLUGS/install-fzf.sh
profileStop

# Bindkeys
source ~/.zsh-bindkeys.zsh
