# Colors setups
export LS_COLORS="ow=01;36;40"          # better ls dir colors

# Man better coloring
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# Pager
export PAGER=less
export LESS=-R                         # better less colors
export LESSCHARSET='utf-8'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export GREP_COLOR="1;32"                # better grep color from Arch Wiki

# Dirs fn options
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt autocd

# Partial line symbol show setup
PROMPT_EOL_MARK='.'

# Misc
setopt extendedglob                    # globling see zsh.md
setopt no_beep                         # no beep on error
setopt interactivecomments	           # enable comments on the command-line

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

autoload -U edit-command-line         # edit command in editro (in vim)
zle -N edit-command-line
