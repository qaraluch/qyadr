# ZSH-AUTOSUGGESTIONS - install & setup
# Home URL: [zsh-users/zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)

# Switch
## TODO: move to config
export PLUG_INSTALL_ZSH_AUTOSUGGESTIONS='Y'

# Vars
readonly plugName='zsh-autosuggestions'
readonly plugInstallerName='zsh-autosuggestions.zsh'
readonly plugGitURL='https://github.com/zsh-users/zsh-autosuggestions.git'

readonly plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
readonly plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )
readonly plugCommandInstaller=( source "${plugCacheDirPath}/${plugInstallerName}" )

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
    local execPlugCommand=$("${plugCommandInstaller[@]}")
fi

# SETUP part ----------------------------------------------------------------------------------
# n/n