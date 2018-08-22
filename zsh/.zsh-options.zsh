# Colors setups 
export LS_COLORS="ow=01;36;40"          # better ls dir colors

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

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

autoload -U edit-command-line         # edit command in editro (in vim)
zle -N edit-command-line

# Bindkeys
bindkey '\C-x\C-e' edit-command-line              # ctrl-x ctrl-e - edit command in editro (in vim)
bindkey "\C-x\C-l" zle-insert-last-typed-word     # ctrl-x ctrl-l - insert last typed word, see: .functions/zsh-terminal.zsh
bindkey '\C-x\C-b' zle-slash-backward-kill-word   # ctrl-x ctrl-b - (like back) slash cut paths, see: .functions/zsh-terminal.zsh 
