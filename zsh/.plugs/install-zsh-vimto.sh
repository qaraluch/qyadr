# ZSH-VIMTO - install & setup
# Home URL: [laurenkt/zsh-vimto: Improved zsh vim mode (bindkey -v) plugin](https://github.com/laurenkt/zsh-vimto)

# Vars
plugName='zsh-vimto'
plugInstallerName='zsh-vimto.zsh'
plugGitURL='https://github.com/laurenkt/zsh-vimto.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )
plugCommandInstaller=( source "${plugCacheDirPath}/${plugInstallerName}" )

# First time installation
plug-install-zsh-vimto() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_ZSH_VIMTO ; then
    plug-install-zsh-vimto
fi

# Uninstall
plug-uninstall-zsh-vimto() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_ZSH_VIMTO ; then
    plug-uninstall-zsh-vimto
fi

# Source
if _switchY $PLUG_INSTALL_ZSH_VIMTO && [[ -d $plugCacheDirPath ]]; then
    local execPlugCommand=$("${plugCommandInstaller[@]}")
fi

# SETUP part ----------------------------------------------------------------------------------
# n/n