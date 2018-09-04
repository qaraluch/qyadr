# Bindkeys
bindkey '^ ' autosuggest-accept                   # ctrl+space (or right arrow)
bindkey '\C-x\C-e' edit-command-line              # ctrl-x ctrl-e - edit command in editro (in vim)
bindkey "\C-x\C-l" zle-insert-last-typed-word     # ctrl-x ctrl-l - insert last typed word, see: .functions/zsh-zle.zsh
bindkey '\C-x\C-b' zle-slash-backward-kill-word   # ctrl-x ctrl-b - (like back) slash cut paths, see: .functions/zsh-zle.zsh 
bindkey '\C-x\C-f' zle-jump-after-first-word      # ctrl-x ctrl-f - jum after first word to add aoptions, see: .functions/zsh-zle.zsh 

# Fzf default
#   * `C+G` - fzf-marks - show
#   * `C+T` - fzf - insert file name from cwd
#   * `A+C` - fzf - cd dir
#   * `C+R` - fzf - history

# bindkey '^N' '_my_zle_widget_mygit_get_status_item'     # C+N - get & clip git status item; see: .rc_git
# bindkey '\eo' '_my_zle_widget_myfzf_locate_file'        # A+o - locate file
