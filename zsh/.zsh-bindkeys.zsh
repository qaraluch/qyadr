# Bindkeys
bindkey '^ ' autosuggest-accept                   # ctrl+space (or right arrow)
bindkey '\C-x\C-e' edit-command-line              # ctrl-x ctrl-e - edit command in editor (in vim)
bindkey "\C-x\C-l" zle-insert-last-typed-word     # ctrl-x ctrl-l - insert last typed word, see: .functions/zsh-zle.zsh
bindkey '\C-x\C-f' zle-jump-after-first-word      # ctrl-x ctrl-f - jump after first word to add options, see: .functions/zsh-zle.zsh

# Fzf  and fzf-marks default (for reference)
#   * `C+G` - fzf-marks - show
#   * `C+T` - fzf - insert file name from cwd
#   * `A+C` - fzf - cd dir
#   * `C+R` - fzf - history

# bindkey '\eo' '_my_zle_widget_myfzf_locate_file'        # A+o - locate file
