# Profiling fns
profileFor() { if [[ "$QYADR_PROFILE_ZSH" == "Y" ]] ; then profileMsg=${1:-Run profile for sth...} ; _timer=$(($(date +%s%N)/1000000)) ; fi ; }
profileStop() { if [[ "$QYADR_PROFILE_ZSH" == "Y" ]] ; then _now=$(($(date +%s%N)/1000000)) ; echo "[!] ---> elapsed: $(($_now-$_timer)) ms for: ${profileMsg}" ; fi ; }

# Qyadr config
[ -f ~/.qyadr-config ] && source ~/.qyadr-config

# Vars
export QYADR_ROOT="${HOME}/.qyadr"                                   # dotfiles path, used in aliases
export QYADR_PLUGS_ROOT="${HOME}/.plugs"

# Path
export PATH=$HOME/.scripts:$PATH

# Sources
profileFor 'all fns'
for file ($HOME/.functions/*.{sh,zsh}) source $file
profileStop

profileFor 'zsh options'
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-completion.zsh ] && source ~/.zsh-completion.zsh
profileStop

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

profileFor 'plugin - fzf-marks'
source $QYADR_PLUGS_ROOT/install-fzf-marks.sh
profileStop

profileFor 'plugin - zsh-abbrev-alias'
source $QYADR_PLUGS_ROOT/install-zsh-abbrev-alias.sh
profileStop

# Env - wsl
##TODO: dokonczyc
if [[ "$QYADR_ENV" == "wsl" ]] ; then
  [ -f ~/.wsl_test ] && source ~/.wsl_test
fi

# Bindkeys
source ~/.zsh-bindkeys.zsh
