# ZSH-AUTOSUGGESTIONS - install & setup
# Home URL: [zsh-users/zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)

# Vars
plugName='zsh-autosuggestions'
plugInstallerName='zsh-autosuggestions.zsh'
plugGitURL='https://github.com/zsh-users/zsh-autosuggestions.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-zsh-autosuggestions() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_ZSH_AUTOSUGGESTIONS ; then
    plug-install-zsh-autosuggestions
fi

# Uninstall
plug-uninstall-zsh-autosuggestions() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_ZSH_AUTOSUGGESTIONS ; then
    plug-uninstall-zsh-autosuggestions
fi

# Source
if _switchY $PLUG_INSTALL_ZSH_AUTOSUGGESTIONS && [[ -d $plugCacheDirPath ]]; then
    source "${plugCacheDirPath}/${plugInstallerName}"
fi

# SETUP part ----------------------------------------------------------------------------------
# n/n