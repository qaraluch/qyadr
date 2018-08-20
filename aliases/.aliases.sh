# TOPICAL ORDER ------------------------------------------------------------
# qyadr - dotfiles mgmt 
alias qyadr-purge='bash ~/.qyadr-purge.sh'
alias qyadr-purge-repo='rm -rf $D_QYADR/.git'     # env from .zshrc
alias qyadr-install='bash ~/.qyadr-install.sh'
alias qyadr-update='bash ~/.qyadr/update.sh'

# zsh - mgmt
alias reload='zsh-reload'                      # .functions/zsh-mgmt.sh
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

# git - see: .functions/gis.sh
alias g='git-g-alias'
alias ga='git-add-status'
alias gaac='git-add-all-commit'
alias gaacm='git-add-all-commit-message'
alias gaaca='git-add-all-commit-amend'
alias gac='git-add-commit'
alias gacm='git-add-commit-message'
alias gacma='git-add-commit-amend'
alias gauc='git-add-update-commit'
alias gaucm='git-add-update-commit-message'
alias gauca='git-add-update-commit-amend'
alias gc="git-commit-better"
alias gca="git-commit-amend"
alias gch='git checkout'
alias gchm='git checkout master'
alias gcm="git-commit-message"
alias gl='git-log-recent 10'
alias gld='git-log-date 10'
alias glt='git-log-tree'
alias gp='git-push'
alias gpforce='git-push --force'

alias h='show-history'
alias ha='show-history-all'
alias hs='show-history-screen'


alias man='man-better-command'                          # .functions/better-commands.sh
alias mv='mv -iv'
alias mvt='mv -ivt'                                     # move to the target

alias l='ls-default'
alias ll='ls-long'
alias ln='ln -iv'
alias llnd='ls-long-no-dotfiles'
alias lls='ls-long-size'
alias llt='ls-long-time'
alias ls='ls --color=auto --group-directories-first'

alias rm='rm -Irf'
alias take='mkdir-and-cd-better-command'