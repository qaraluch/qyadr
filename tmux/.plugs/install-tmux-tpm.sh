# TMUX-TPM - install
# Home URL: [tmux-plugins/tpm: Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

# Vars
plugName='tpm'
# plugInstallerName='tmux-tpm.zsh'
plugGitURL='https://github.com/tmux-plugins/tpm'

plugCacheDirPath="${HOME}/.tmux/plugins/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-tmux-tpm() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

plug-install-tmux-tpm

# Uninstall
plug-uninstall-tmux-tpm() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

