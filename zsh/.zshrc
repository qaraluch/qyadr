# Vars
export D_QYADR="${HOME}/.qyadr"                                      # dotfiles path, used in aliases 
export ANTIGEN_HOME="${HOME}/.antigen"

export PATH=$HOME/.scripts:$PATH

# Sources
for FILE ($HOME/.functions/*.sh) source $FILE
[ -f ~/.zsh-options.zsh ] && source ~/.zsh-options.zsh
[ -f ~/.zsh-install.zsh ] && source ~/.zsh-install.zsh
[ -f ~/.zsh-prompt.zsh ] && source ~/.zsh-prompt.zsh
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
[ -f ~/.zsh-test.zsh ] && source ~/.zsh-test.zsh              # for rapid testing purposes only

# Antigen
source "$HOME/.antigen.zsh"
antigen bundle softmoth/zsh-vim-mode
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle urbainvaes/fzf-marks
antigen apply