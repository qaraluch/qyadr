# TOPICAL ORDER ------------------------------------------------------------
# qyadr - dotfiles mgmt 
alias qyadr-purge='./.qyadr-purge.sh'
alias qyadr-install='./.qyadr-install.sh'
alias qyadr-update='./.qyadr/update.sh'

# zsh - mgmt
alias reload='zsh-reload'                     # .functions/zsh-mgmt.sh
alias time-zsh='zsh-measure-loading-times'     # .functions/zsh-mgmt.sh

# dirs - list contents
alias ls-default='ls -1FcrtA'         # 1 line, classify, ? , reverse, by time, almost all
alias ls-long='ls -lAh'               # long, almost all, human
alias ls-long-size='ls -lahS'         # long, all, human, by size 
alias ls-long-time='ls -laht'         # long, all, human, by time 
alias ls-long-no-dotfiles='ls -lh'    # long, all, human, by time 

# dirs - movements
alias cd-grandparent='../..'
alias cd-great-grandparent='../../..'
alias show-dirs='dirs -v | head -10'

# history
alias show-history='history -20'
alias show-history-screen='history -60'
alias show-history-all='history 1'

# ALPHABETICALLY ACRONYMS --------------------------------------------------
alias -g ...='cd-grandparent'
alias -g ....='cd-great-grandparent'

alias -- -='cd -'
alias -- ~='cd ~'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias cp='cp -ivrf'
alias d='show-dirs'
alias diff='diff --color=auto'
alias e='exit'
alias grep='grep --color=auto'

alias h='show-history'
alias ha='show-history-all'
alias hs='show-history-screen'

alias ln='ln -iv'

alias man='man-better-command'                          # .functions/better-commands.sh
alias mv='mv -iv'
alias mvt='mv -ivt'                                     # move to the target

alias l='ls-default'
alias ll='ls-long'
alias llnd='ls-long-no-dotfiles'
alias lls='ls-long-size'
alias llt='ls-long-time'
alias ls='ls --color=auto --group-directories-first'

alias rm='rm -Irf'
