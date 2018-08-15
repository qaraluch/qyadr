# TOPICAL ORDER ------------------------------------------------------------
# qyadr - dotfiles mgmt 
alias qyadr-purge='./.qyadr-purge.sh'
alias qyadr-install='./.qyadr-install.sh'
alias qyadr-update='./.qyadr/update.sh'

# zsh - mgmt
alias reload='reload-zsh'
alias exit-zsh='exit'

# dirs - list contents
alias ls-default='ls -1FcrtA'         # 1 line, classify, ? , reverse, by time, almost all
alias ls-long='ls -lAh'               # long, almost all, human
alias ls-long-size='ls -lahS'         # long, all, human, by size 
alias ls-long-time='ls -laht'         # long, all, human, by time 
alias ls-long-no-dotfiles='ls -lh'    # long, all, human, by time 

# history
alias show-history='history -20'
alias show-history-screen='history -60'
alias show-history-all='history 1'

# ALPHABETICALLY ACRONYMS --------------------------------------------------
alias e='exit-zsh'
alias h='show-history'
alias ha='show-history-all'
alias hs='show-history-screen'
alias l='ls-default'
alias ll='ls-long'
alias llnd='ls-long-no-dotfiles'
alias lls='ls-long-size'
alias llt='ls-long-time'
alias ls='ls --color=auto --group-directories-first'