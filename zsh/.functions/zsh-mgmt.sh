# ZSH management, helper and utils functions
# dependencies:
# - .functions/utils.sh

zsh-reload() {
  if [[ "$1" == "-s" ]] ; then   # -s like source or soft
    source ~/.zshrc
    _echoIt "$_QDel" "Reloaded ${_Qcy}ZSH${_Qce} shell config." "${_Qit}"
  else
    _echoIt "$_QDel" "About to reloaded ${_Qcy}ZSH${_Qce} shell itself..." "${_Qiw}"
    exec ${SHELL}
  fi
}

zsh-measure-loading-times() {
  local outputPath="${HOME}/.zsh-profiling.log"
  local timeStamp=$(_getTimeStampHuman)
  _echoIt "$_QDel" "About to measure ZSH loading time..."
  echo "\n ---------- ${timeStamp} --------------------------------------------" >> $outputPath
  for i in {1..3}; do (zsh-run-loading-time >/dev/null ) 2>> $outputPath 2>&1; done
  sleep 0.5
  _echoIt "$_QDel" "  --> See historical data in file: $outputPath"
  _echoDone
}

zsh-run-loading-time() {
  time zsh -i -c exit
}

# Prompt hook function to add empty line before prompt redraw
# precmd() { print "" }
