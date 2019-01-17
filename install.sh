#!/usr/bin/env bash
# Author: qaraluch - 01.2019 - MIT
# Project: QYADR

# Settings:
readonly installListDefaultPath="${HOME}/.qyadr-install-list.csv"
readonly dotfilesHomeDir='.qyadr'

# Calculated vars:
readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"
readonly defaultEnvValue=$(cat "${dotfilesPath}/qyadr/.qyadr-config.example" | gawk 'match($0, /.*QYADR_ENV=(.*?)/,a) {print a[1];}' | sed "s/['\"]//g")

# Auto generated utility variables
readonly _pArgs="$@"
readonly _pDel='[ QYADR ]'
readonly _pName=$(basename $0)

# Utils:
readonly _cr=$'\033[0;31m'            # color red
readonly _cg=$'\033[1;32m'            # color green
readonly _cy=$'\033[1;33m'            # color yellow
readonly _cb=$'\033[1;34m'            # color blue
readonly _cm=$'\033[1;35m'            # color magenta
readonly _cc=$'\033[1;36m'            # color cyan
readonly _ce=$'\033[0m'               # color end

readonly _it="[ ${_cg}✔${_ce} ]"      # icon tick
readonly _iw="[ ${_cy}!${_ce} ]"      # icon warn
readonly _ic="[ ${_cr}✖${_ce} ]"      # icon cross
readonly _ia="[ ${_cy}?${_ce} ]"      # icon ask

echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}

errorExit() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-"$_ic"} ; echo "${delimiter}${icon} ${msg}" 1>&2 ; exit 1
}

isDir() {
  local dir=$1
  [[ -d $dir ]]
}

isFile() {
  local file=$1
  [[ -f $file ]]
}

isNotFile() {
  local file=$1
  [[ ! -f $file ]]
}

isStringEmpty() {
  local var=$1
  [[ -z $var ]]
}

isStringEqual(){
  [[ "$1" == "$2" ]]
}

echoDone() {
  echoIt "$_pDel" "DONE!" "$_it" ; echo >&2
}

isStringEqualY() {
  local string=$1
  [[ "$string" == "Y" ]]
}

switchY() {
  local switch=$1
  if isStringEqualY $switch; then
    return 0
  else
    return 1
  fi
}

echoDone() {
  echoIt "$_pDel" "DONE!" "$_it"
  echo >&2
}

# Errors and warns:
errorExit_abortScript() {
  errorExit "$_pDel" "Aborting script!"
}

errorExit_noInstallListFound() {
  errorExit "$_pDel" "Not found installation list: $1"
}

errorExit_passPkgName() {
  errorExit "$_pDel" "Pass package name!"
}

errorExit_stowError() {
  echoIt "${_pDel}" "Cannot un/stowed package name: $1 (Is this correct name?)" "$_iw"
  errorExit_abortScript
}

warnAlreadyExists() {
  echoIt "$_pDel" "   ... file already exists: ${1} ?! No action taken!"
}

# Msgs:
msg_reloadAndEdit() {
  echoIt "$_pDel" "${_cy}Warn: login again to apply changes!${_ce}" "${_iw}"
  echoIt "$_pDel" "${_cy}Warn:${_ce} Fill up data in ${_cy}.qyadr-sec${_ce} file!" "${_iw}"
}

msg_installWelcome() {
  echoIt
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce} - Installation script"
}

msg_startInstallation() {
  local installationType="$1"
  echoIt "$_pDel" "About to [ ${_cg}${installationType}${_ce} ] ..."
  echoIt "$_pDel" "         - in home dir:             ${_cy}$HOME${_ce}"
  echoIt "$_pDel" "         - from dotfiles repo:      ${_cy}$dotfilesPath${_ce}"
}

msg_startReload() {
  echoIt "$_pDel" "About to [ ${_cg}reload${_ce} ] ..."
  echoIt "$_pDel" "         - in home dir:             ${_cy}$HOME${_ce}"
  echoIt "$_pDel" "         - from dotfiles repo:      ${_cy}$dotfilesPath${_ce}"
}

msg_aPkg(){
  local pkgName="$1"
  echoIt "$_pDel" "   ... a package named:"
  echoIt "$_pDel" "         [ ${_cg}${pkgName}${_ce} ]"
  echoIt
}

msg_aEnv(){
  local envName="$1"
  echoIt "$_pDel" "   ... a environment package named:"
  echoIt "$_pDel" "         [ ${_cg}${envName}${_ce} ]"
  echoIt
}

msg_aListOfPackages(){
  local envName="$1"
  echoIt "$_pDel" "   ... all listed packages for environment:"
  echoIt "$_pDel" "         [ ${_cg}${envName}${_ce} ]"
  echoIt
}

msg_unstowAll(){
  echoIt "$_pDel" "   ... all packages whatsoever (!)"
  echoIt
}

# CLI:
printUsage() {
  cat <<EOL

  Help:
  ---------
  ${_cy}${_pName}${_ce} - install (stow) qyadr packages.

  Usage:
    ${_pName} ${_cy}ls${_ce}                               - show list all packages (except of env ones).
    ${_pName} ${_cy}ls${_ce} [env]                         - show only environment packages.

    ${_pName} ${_cy}install${_ce}                          - install default environment and its packages.
                                                  Packages are installed according to 'install-list.csv'.
    ${_pName} ${_cy}install${_ce} -e wsl                   - install 'wsl' environment and its packages.
    ${_pName} ${_cy}install${_ce} -env wsl
    ${_pName} ${_cy}install${_ce} pkg <package-name>       - install particular package.
    ${_pName} ${_cy}install${_ce} env <env-name>           - install particular environment (not its dependant packages).
    ${_pName} ${_cy}install${_ce} -u                       - uninstall flag:
    ${_pName} ${_cy}install${_ce} --uninstall
                                                  example: install -u pkg zsh

    ${_pName} ${_cy}reload${_ce} <package-name>            - reload particular package (not environment).

  Manual stow commands:
    stow -vt ~ -d .qyadr <package-name> # installation
    stow -vt ~ -d .qyadr -D <package-name> # remove

EOL
  exit $1
}

ifNoArgsPrintUsage(){
  isStringEmpty $1 \
    && printUsage 1
}

parseOptions(){
  while [[ $# -gt 0 ]] ; do
    itm="$1"
    case $itm in
      -u|--uninstall)
      flagUninstall="Y"
      shift
      ;;
      -e|--env)
      flagEnv='Y'
      flagEnvName="$2"
      shift
      shift
      ;;
      reload)
      cmd="$itm"
      shift
      ;;
      install)
      cmd="$itm"
      shift
      ;;
      ls)
      cmd="$itm"
      shift
      ;;
      -h|--help)
      printUsage 1
      ;;
      *)
      positional+=("$1")
      shift
      ;;
    esac
  done
}

# Main:
main() {
  ifNoArgsPrintUsage $_pArgs
  checkIfListExists
  # cli
  local cmd
  local positional=()
  local flagEnv='N'
  local flagEnvName
  local flagUninstall='N'
  # lists
  declare -a envsList
  declare -a pkgsList_Min
  declare -a pkgsList_Arch
  declare -a pkgsList_WSL
  declare -a pkgsList_Proto
  readInstalList
  declare -a pkgsList_All
  pkgsList_All+=( \
    "${pkgsList_Min[@]}" \
    "${pkgsList_Arch[@]}" \
    "${pkgsList_WSL[@]}" \
    "${pkgsList_Proto[@]}" )
  parseOptions $_pArgs
  set -- "${positional[@]}"
  msg_installWelcome
  if [[ $cmd == "reload" ]] ; then
    local pkgName="$1"
    isStringEmpty "$pkgName" && errorExit_passPkgName
    execCmd_reload
  fi
  if [[ $cmd == "install" ]] ; then
    local subCmd="$1"
    local subCmdArg="$2"
    execCmd_install
  fi
  if [[ $cmd == "ls" ]] ; then
    local subCmd="$1"
    lsPackages "$subCmd"
  fi
}

# Fns - main:
checkIfListExists() {
  if isNotFile $installListDefaultPath ; then
    errorExit_noInstallListFound $installListDefaultPath
  fi
}

readInstalList() {
  while IFS=, read -r entity env name; do
    n=$((n+1)) # not title row
    case "$entity" in
      "env") envsList+=( "$name" );;
    esac
    case "$env" in
      "min") pkgsList_Min+=( "$name" );;
      "arch") pkgsList_Arch+=( "$name" );;
      "wsl") pkgsList_WSL+=( "$name" );;
      "proto") pkgsList_Proto+=( "$name" );;
    esac
  done < "${installListDefaultPath}"
}

# Command ls:
lsPackages() {
  local kind="$1"
  if isStringEqual "$kind" 'env' ; then
    echoIt "$_pDel" "List of ${_cy}environmental${_ce} packages:"
    for pack in "${envsList[@]}" ; do
      echoIt "$_pDel" " - ${pack}"
    done
  else
    echoIt "$_pDel" "List of ${_cy}all${_ce} packages:"
    for pack in "${pkgsList_All[@]}" ; do
      echoIt "$_pDel" " - ${pack}"
    done
  fi
}

# Command install:
execCmd_install() {
  # Pre-installation shielding actions
  renameDefaultFiles
  if switchY $flagUninstall ; then
    msg_startInstallation 'uninstall'
    execSubCmd_uninstall
  else
    msg_startInstallation 'install'
    execSubCmd_install
  fi
  # Post-installation actions
  copyExamples
  copySec
  msg_reloadAndEdit
  echoDone
}

execSubCmd_install() {
  if isStringEqual "$subCmd" 'pkg' ; then
    msg_aPkg "$subCmdArg"
    stowPkg "$subCmdArg"
  elif isStringEqual "$subCmd" 'env' ; then
    msg_aEnv "$subCmdArg"
    stowEnv "$subCmdArg"
  else
    if switchY "$flagEnv" ; then
      msg_aListOfPackages "$flagEnvName"
      stowAll "$flagEnvName"
    else
      msg_aListOfPackages "$defaultEnvValue"
      stowAllDefault
    fi
  fi
}

execSubCmd_uninstall() {
  if isStringEqual "$subCmd" 'pkg' ; then
    msg_aPkg "$subCmdArg"
    unstowPkg "$subCmdArg"
  elif isStringEqual "$subCmd" 'env' ; then
    msg_aEnv "$subCmdArg"
    unstowEnv "$subCmdArg"
  else
    msg_unstowAll
    unstowAll
  fi
}

#Stow commands:
cmd_stow(){
  stow -vd ${dotfilesPath} -S ${pack} -t ${HOME}
}

cmd_unstow(){
  stow -vd ${dotfilesPath} -D ${pack} -t ${HOME}
}

stowPkg() {
    local pack=$1
    if isDir "$dotfilesPath/$pack" ; then
      cmd_stow
      echoIt "$_pDel" "Stowed package name: ${_cy}${pack}${_ce}" "$_it"
    else
      errorExit_stowError ${pack}
    fi
}

unstowPkg() {
  local pack=$1
  if isDir "$dotfilesPath/$pack" ; then
    cmd_unstow
    echoIt "$_pDel" "Unstowed package name: ${_cy}${pack}${_ce}" "$_it"
  else
    errorExit_stowError
  fi
}

stowEnv() {
  local envPackName="${1:-"$defaultEnvValue"}"
  local pack="_${envPackName}"
  local envDir="${dotfilesPath}/${pack}"
  if isDir "$envDir" ; then
    cmd_stow
    echoIt "$_pDel" "Stowed environment package name: ${_cy}${envPackName}${_ce}" "$_it"
  else
    errorExit_stowError ${pack}
  fi
  changeEnvValueInConfig "$envPackName"
}

changeEnvValueInConfig() {
  local changedValue=$1
  local config="${HOME}/.qyadr-config"
  if isFile $config; then
    sed -i "s/\(^.*QYADR_ENV=\).*/\1'${changedValue}'/" "$config"
    [[ $? ]] && echoIt "$_pDel" "     ... changed QYADR_ENV value in: ${config}"
  fi
}

unstowEnv() {
  local envPackName="${1:-"$defaultEnvValue"}"
  local pack="_${envPackName}"
  local envDir="${dotfilesPath}/${pack}"
  if isDir "$envDir" ; then
    cmd_unstow
    echoIt "$_pDel" "Unstowed environment package name: ${_cy}${pack}${_ce}" "$_it"
  else
    errorExit_stowError ${pack}
  fi
}

unstowAll() {
  bulkUnstowEnv
  bulkUnstowPkg
}

bulkUnstowPkg() {
  for pack in "${pkgsList_All[@]}" ; do
    unstowPkg $pack
  done
}

bulkUnstowEnv() {
  for env in "${envsList[@]}" ; do
    unstowEnv $env
  done
}

stowAllDefault(){
  stowEnv #default env specified in .qyadr-config
  stowPkgsMin
  stowPkgsEnvDependant #default like above
  stowPkgsProto
}

stowAll(){
  local env="$1"
  stowEnv "$env"
  stowPkgsMin
  stowPkgsEnvDependant "$env"
  stowPkgsProto
}

stowPkgsMin() {
  for pack in "${pkgsList_Min[@]}" ; do
    stowPkg $pack
  done
}

stowPkgsProto() {
  for pack in "${pkgsList_Proto[@]}" ; do
    stowPkg $pack
  done
}

stowPkgsEnvDependant() {
  # only arch for now (no wsl dependant pkgs)
  local whatEnv="${1:-"arch"}"
  if isStringEqual "$whatEnv" "arch" ; then
    for pack in "${pkgsList_Arch[@]}" ; do
      stowPkg $pack
    done
  fi
}

# Shielding actions:
renameDefaultFiles() {
  # Rename default system config files
  # to avoid stow conflict.
  rename_bashrc
  rename_i3config
  rename_xinitrc
}

rename_bashrc() {
  local file="${HOME}/.bashrc"
  if ( isFile "${file}" && [[ ! -L "${file}" ]] ) ; then
    mv "${file}"{,.back}
  fi
}

rename_i3config() {
  local file="${HOME}/.config/i3/config"
  if ( isFile "${file}" && [[ ! -L "${file}" ]] ) ; then
    mv "${file}"{,.back}
  fi
}

rename_xinitrc() {
  local file="${HOME}/.xinitrc"
  if ( isFile "${file}" && [[ ! -L "${file}" ]] ) ; then
    mv "${file}"{,.back}
  fi
}

# Post-installation actions:
copyExamples(){
  echoIt "$_pDel" "About to copy qyadr ${_cy}example${_ce} files..."
  copyExample_config
}

copyExample_config() {
  local filePath="${HOME}/.qyadr-config.example"
  local destPath=${filePath%%.example}
  if isFile ${filePath} ; then
    if isFile ${destPath} ; then
      warnAlreadyExists ${destPath}
    else
      cp -f $filePath $destPath
      [[ $? ]] && echoIt "$_pDel" "   ...  ${filePath} -> ~/${_cy}${destPath}${_ce}"
    fi
  fi
}

copySec(){
  echoIt "$_pDel" "About to copy qyadr ${_cy}sec${_ce} files..."
  copySec_qyadr
}

copySec_qyadr() {
  local filePath="${HOME}/.qyadr-sec.sec"
  local destPath=${filePath%%.sec}
  if isFile ${filePath} ; then
    if isFile ${destPath} ; then
      warnAlreadyExists ${destPath}
    else
      cp -f $filePath $destPath
      [[ $? ]] && echoIt "$_pDel" "   ...  ${filePath} -> ~/${_cy}${destPath}${_ce}"
    fi
  fi
}

# Command reload:
execCmd_reload() {
  msg_startReload
  msg_aPkg "$pkgName"
  unstowPkg "$pkgName"
  stowPkg "$pkgName"
  echoDone
}

# Main exec
main