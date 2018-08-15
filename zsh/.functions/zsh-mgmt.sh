# ZSH management functions
# dependencies:
# - .functions/utils.sh

reload-zsh() {
  source ~/.zshrc
  echoIt "Reloaded ${C_Y}ZSH${C_E} shell config." "${I_T}"
}
