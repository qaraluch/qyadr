# Plugins Bindkeys
bindkey '^ ' autosuggest-accept                   # ctrl+space (or right arrow)
bindkey -M viins 'jj' vi-cmd-mode                 # escape remap

# Fzf and fzf-marks default (for reference)
# - ctrl-g - fzf-marks - show
# - ctrl-t - fzf - insert file name from cwd
# - alt-c - fzf - cd dir
# - ctrl-r - fzf - history

# My custom zle function Bindkeys
bindkey '\C-x\C-e' edit-command-line              # ctrl-x ctrl-e - edit command in editor (in vim)
bindkey '\C-x\C-l' zle-insert-last-typed-word     # ctrl-x ctrl-l - insert last typed word, see: .functions/zsh-zle.zsh
bindkey '\C-x\C-f' zle-jump-after-first-word      # ctrl-x ctrl-f - jump after first word to add options, see: .functions/zsh-zle.zsh

# Extra functionality from oh-my-zsh
# start typing + [Up/Down-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# for convenience
bindkey '^[[1;5C' forward-word                        # ctrl-> - move forward one word
bindkey '^[[1;5D' backward-word                       # ctrl-< - move backward one word

# for auto-complete
bindkey "^[[Z" reverse-menu-complete     # shift-tab - move through the completion menu backwards

# TODO:
# bindkey '\eo' '_my_zle_widget_myfzf_locate_file'        # A+o - locate file