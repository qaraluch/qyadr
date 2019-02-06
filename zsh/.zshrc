# Profiling fns
profileFor() { if [[ "$QYADR_PROFILE_ZSH" == "Y" ]] ; then profileMsg=${1:-Run profile for sth...} ; _timer=$(($(date +%s%N)/1000000)) ; fi ; }
profileStop() { if [[ "$QYADR_PROFILE_ZSH" == "Y" ]] ; then _now=$(($(date +%s%N)/1000000)) ; echo "[!] ---> elapsed: $(($_now-$_timer)) ms for: ${profileMsg}" ; fi ; }

# Qyadr config
[ -f ~/.qyadr-config ] && source ~/.qyadr-config

# Sources
profileFor 'all fns'
for file ($HOME/.functions/*.{sh,zsh}) source $file
profileStop

profileFor 'zsh options'
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.zsh-completion.zsh ] && source ~/.zsh-completion.zsh
profileStop

# Env
profileFor 'env'
# Sec env
readonly qyadrSecFile="${HOME}/.qyadr-sec"
if [[ -f ${qyadrSecFile} ]] ; then
  source ~/.qyadr-sec
else
  _echoIt "${_QDel}" "[ ${_cy}WARN${_ce} ] Not found file: ${_cy}${qyadrSecFile}${_ce} to source!" "${_iw}"
fi
# Environment env
if _isStringNotEmpty "$QYADR_ENV" ; then
  readonly envEntryPointPath="${HOME}/.zshrc-${QYADR_ENV}"
  [ -f $envEntryPointPath ] && source $envEntryPointPath
fi
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

profileFor 'plugin - tmux-tpm'
# [[ -f "${QYADR_PLUGS_ROOT}/install-tmux.tpm.sh" ]] && source $QYADR_PLUGS_ROOT/install-tmux-tpm.sh
source $QYADR_PLUGS_ROOT/install-tmux-tpm.sh
profileStop

# Bindkeys
[ -f ~/.zsh-bindkeys.zsh ] && source ~/.zsh-bindkeys.zsh

# Aliases
[ -f ~/.aliases.sh ] && source ~/.aliases.sh

