# colors setups 
export LS_COLORS="ow=01;36;40"          # better ls dir colors

export LESS=-R                         # better less colors 
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export GREP_COLOR="1;32"                # better grep color from Arch Wiki

# dirs fn options
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt autocd

# partial line symbol show setup
PROMPT_EOL_MARK='.'