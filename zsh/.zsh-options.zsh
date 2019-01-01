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
setopt pushd_minus
setopt auto_cd

# Partial line symbol show setup
PROMPT_EOL_MARK='.'

# Misc
setopt extendedglob                    # globling see zsh.md
setopt no_beep                         # no beep on error
setopt interactivecomments	           # enable comments on the command-line

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

autoload -U edit-command-line         # edit command in editor (in vim)
zle -N edit-command-line

# History config
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh-history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_find_no_dups	    # when searching history, show no duplicates
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_all_dups   # remove older duplicate entries from history
setopt hist_save_no_dups      # means that whatever options are set for the current session, the shell is not to save duplicated lines more than once
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt hist_reduce_blanks     # tide up command from extra blank chars
setopt inc_append_history     # add commands to HISTFILE in order of execution