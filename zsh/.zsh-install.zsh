# First time installations of zsh dependencies

# Antigen
if [[ ! -d "$ANTIGEN_HOME" ]]; then
    echoIt "It seemed you have no installed a '${C_Y}Antigen${C_E}' zsh plugin manager." "$I_W"
    echoIt "About to install it..."
    curl -L git.io/antigen > .antigen.zsh
    echoDone
fi
