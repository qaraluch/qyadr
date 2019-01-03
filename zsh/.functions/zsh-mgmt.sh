# ZSH management, helper and utils functions
# dependencies:
# - .functions/utils.sh

zsh-reload() {
  source ~/.zshrc
  _echoIt "$_QDel" "Reloaded ${_Qcy}ZSH${_Qce} shell config." "${_Qit}"
}

zsh-measure-loading-times() {
  local outputPath="${HOME}/.zsh-profiling.log"
  local timeStamp=$(_getTimeStampHuman)
  _echoIt "$_QDel" "About to measure ZSH loading time..."
  echo "\n ---------- ${timeStamp} --------------------------------------------" >> $outputPath
  for i in {1..3}; do (zsh-run-loading-time >/dev/null ) 2>> $outputPath 2>&1; done
  _echoIt "$_QDel" "  --> See historical data in file: $outputPath"
  _echoDone
}

zsh-run-loading-time() {
  time zsh -i -c exit
}

# Prompt hook function to add empty line before prompt redraw
# precmd() { print "" }
