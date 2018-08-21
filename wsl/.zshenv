# Zplug and Antigen
# WSL workaround not to show:
# /home/ag/antigen.zsh:27: nice(5) failed: operation not permitted
# during init
# see: [autojump_chpwd:4: nice(5) failed: operation not permitted · Issue #474 · wting/autojump](https://github.com/wting/autojump/issues/474)
# see: [Operation Not permitted, when installing zplug plugins on windows subsystem for linux (WSL) · Issue #398 · zplug/zplug](https://github.com/zplug/zplug/issues/398)
# see: [Error message with ZSH and use of "&" in Creators Update · Issue #1887 · Microsoft/WSL](https://github.com/Microsoft/WSL/issues/1887)
unsetopt BG_NICE
