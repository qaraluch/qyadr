# First time installations of zsh dependencies

# Zplug
if [[ ! -d "$ZPLUG_HOME" ]]; then
    echoIt "It seemed you have no installed a '${C_Y}zplug${C_E}' zsh plugin manager." "$I_W"
    echoIt "About to install it..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    source "$ZPLUG_HOME/init.zsh"
    zplug update # what's for ?
    echoDone
fi
