# Bindkeys
bindkey '^ ' autosuggest-accept                   # ctrl+space (or right arrow)
bindkey '\C-x\C-e' edit-command-line              # ctrl-x ctrl-e - edit command in editro (in vim)
bindkey "\C-x\C-l" zle-insert-last-typed-word     # ctrl-x ctrl-l - insert last typed word, see: .functions/zsh-terminal.zsh
bindkey '\C-x\C-b' zle-slash-backward-kill-word   # ctrl-x ctrl-b - (like back) slash cut paths, see: .functions/zsh-terminal.zsh 
bindkey '\C-x\C-f' zle-jump-after-first-word      # ctrl-x ctrl-f - jum after first word to add aoptions, see: .functions/zsh-terminal.zsh 

# Fzf default
#   * `C+G` - fzf-marks - show
#   * `C+T` - fzf - file
#   * `A+C` - fzf - cd dir
#   * `C+R` - fzf - history