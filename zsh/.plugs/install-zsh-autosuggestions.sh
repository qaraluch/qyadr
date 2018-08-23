# Home URL: [zsh-users/zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)

# Switch
export PLUG_DO_INSTALL_ZSH_AUTOSUGGESTIONS='Y'

# Vars 
export PLUG_NAME_ZSH_AUTOSUGGESTIONS='zsh-autosuggestions'
export PLUG_FILE_NAME_ZSH_AUTOSUGGESTIONS='zsh-autosuggestions.zsh'
export PLUG_GIT_URL_ZSH_AUTOSUGGESTIONS='https://github.com/zsh-users/zsh-autosuggestions.git'

# Computed Vars
export D_PLUG_ZSH_AUTOSUGGESTIONS="${D_PLUGS}-cache/${PLUG_NAME_ZSH_AUTOSUGGESTIONS}" 
export PLUG_CMD_INSTALLATION_ZSH_AUTOSUGGESTIONS="git clone --depth 1 ${PLUG_GIT_URL_ZSH_AUTOSUGGESTIONS} ${D_PLUG_ZSH_AUTOSUGGESTIONS}"
export PLUG_CMD_SOURCE_ZSH_AUTOSUGGESTIONS="source ${D_PLUG_ZSH_AUTOSUGGESTIONS}/${PLUG_FILE_NAME_ZSH_AUTOSUGGESTIONS}"

# First time installation
zsh-plug-install-zsh-autosugestions () {
    if [[ ! -d $D_PLUG_ZSH_AUTOSUGGESTIONS ]]; then
        echoIt "It seemed you have no installed a '${C_Y}${PLUG_NAME_ZSH_AUTOSUGGESTIONS}${C_E}' plugin." "$I_W"
        echoIt "About to install it..."
        eval $PLUG_CMD_INSTALLATION_ZSH_AUTOSUGGESTIONS
        echoDone
    fi
}

if switchY $PLUG_DO_INSTALL_ZSH_AUTOSUGGESTIONS ; then
    zsh-plug-install-zsh-autosugestions
fi

# Uninstall
zsh-plug-uninstall-zsh-autosugestions () {
    if [[ -d $D_PLUG_ZSH_AUTOSUGGESTIONS ]]; then
        echoIt "About to uninstall a '${C_Y}${PLUG_NAME_ZSH_AUTOSUGGESTIONS}${C_E}' plugin." "$I_W"
        rm -rf $D_PLUG_ZSH_AUTOSUGGESTIONS
        echoDone
    fi
}

if ! switchY $PLUG_DO_INSTALL_ZSH_AUTOSUGGESTIONS ; then
    zsh-plug-uninstall-zsh-autosugestions
fi


# Source
if switchY $PLUG_DO_INSTALL_ZSH_AUTOSUGGESTIONS && [[ -d $D_PLUG_ZSH_AUTOSUGGESTIONS ]]; then
    eval $PLUG_CMD_SOURCE_ZSH_AUTOSUGGESTIONS
fi

# Plugin config