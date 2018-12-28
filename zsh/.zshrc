profileZSH='N'

# Profiling fns
profileFor() { if [[ "$profileZSH" == "Y" ]] ; then profileMsg=${1:-Run profile for sth...} ; _timer=$(($(date +%s%N)/1000000)) ; fi ; }
profileStop() { if [[ "$profileZSH" == "Y" ]] ; then _now=$(($(date +%s%N)/1000000)) ; echo "[!] ---> elapsed: $(($_now-$_timer)) ms for: ${profileMsg}" ; fi ; }

# Vars
export QYADR_ROOT="${HOME}/.qyadr"                                   # dotfiles path, used in aliases
export QYADR_PLUGS_ROOT="${HOME}/.plugs"

# Path
export PATH=$HOME/.scripts:$PATH

# Env
[ -f ~/.qyadr-env ] && export QYADR_ENV=$(cat ~/.qyadr-env)

# Sources
profileFor 'all fns'
for file ($HOME/.functions/*.{sh,zsh}) source $file
profileStop

[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh                     # for rapid testing purposes only

# Plugs
# Create cache dir for plugins if not exists
if [[ ! -d "${QYADR_PLUGS_ROOT}-cache" ]]; then mkdir "${QYADR_PLUGS_ROOT}-cache" ; fi

profileFor 'plugin - highlighting'
source $QYADR_PLUGS_ROOT/install-zsh-syntax-highlighting.sh
profileStop

profileFor 'plugin - vimto'
source $QYADR_PLUGS_ROOT/install-zsh-vimto.sh
profileStop

profileFor 'plugin - suggestions'
source $QYADR_PLUGS_ROOT/install-zsh-autosuggestions.sh
profileStop

profileFor 'plugin - fzf'
source $QYADR_PLUGS_ROOT/install-fzf.sh
profileStop

# Env - wsl
##TODO: dokonczyc
if [[ "$QYADR_ENV" == "wsl" ]] ; then
  [ -f ~/.wsl_test ] && source ~/.wsl_test
fi

# Bindkeys
source ~/.zsh-bindkeys.zsh
