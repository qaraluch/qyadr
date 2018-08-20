# Zplug
# WSL workaround not to show:
# __install__:47: nice(5) failed: operation not permitted
# during plugin installation/updating
# see: [Operation Not permitted, when installing zplug plugins on windows subsystem for linux (WSL) · Issue #398 · zplug/zplug](https://github.com/zplug/zplug/issues/398)
# see: [Error message with ZSH and use of "&" in Creators Update · Issue #1887 · Microsoft/WSL](https://github.com/Microsoft/WSL/issues/1887)
unsetopt BG_NICE
