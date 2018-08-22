# ZSH management, helper and utils functions
# dependencies:
# - .functions/utils.sh

zsh-reload() {
  source ~/.zshrc
  echoIt "Reloaded ${C_Y}ZSH${C_E} shell config." "${I_T}"
}

zsh-measure-loading-times() {
  local OUTPUTFILE="${HOME}/.zsh-time.txt"
  local TIMESTAMP=$(getTimeStampHuman)
  echoIt "About to measure ZSH loading time..."
  echo "\n ---------- ${TIMESTAMP} --------------------------------------------" >> $OUTPUTFILE
  for i in {1..3}; do (zsh-run-loading-time >/dev/null ) 2>> $OUTPUTFILE 2>&1; done
  echo "  --> See historical data in file: $OUTPUTFILE"
  echoDone
}

zsh-run-loading-time() {
  time zsh -i -c exit
}

# Prompt hook function to add empty line before prompt redraw
precmd() { print "" }
