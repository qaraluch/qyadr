#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

set -e

# Setup:
declare -a packs=( \
  qyadr \
  zsh \
  functions \
  aliases \
  scripts \
  git
)

# Utils:
readonly dotfilesHomeDir='.qyadr'

readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"
readonly defaultEnvValue=$(cat "${dotfilesPath}/qyadr/.qyadr-config.example" | gawk 'match($0, /.*QYADR_ENV=(.*?)/,a) {print a[1];}' | sed "s/['\"]//g")
readonly envPackagesList=( $(find "${dotfilesPath}/" -mindepth 1 -maxdepth 1 -type d -name '_*' -printf "%P\n" | sed "s/_//g") )

readonly _pDel='[ QYADR ]'

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

yesConfirmOrAbort() {
  local msg=${1:-'Continue'}
  read -n 1 -s -r -p "${_pDel}${_ia} ${msg} [Y/n]?"
  echo >&2
  REPLY=${REPLY:-'Y'}
  if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
    errorExit_abortScript
  fi
}

isDir() {
  local dir=$1
  [[ -d $dir ]]
}

isFile() {
  local file=$1
  [[ -f $file ]]
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

errorExit_abortScript() {
  errorExit "$_pDel" "Aborting script!"
}

# Main:
main() {
  if isStringEmpty "$@" ; then
    # If args is passed to the script run auto mode
    # otherwise launch interactive one with menu.
    runMainInteractive
  else
    runMainAuto $1 $2
  fi
}

# auto path
runMainAuto() {
  local choice=$1
  local envName=$2
  if [[ "$choice" == 1 ]] ; then
    stowAll
    if isStringEmpty $2 ; then
      stowEnv # default environment
    else
      stowEnv $2
    fi
  elif [[ "$choice" == 2 ]] ; then
    unstowAll
  elif [[ "$choice" == 3 ]] ; then
    renameBashrc
    unstowEnvsAll
    stowEnv $envName
    changeEnvValueInConfig $envName
  else
    quitMenu
  fi
}

# interactive path
runMainInteractive() {
  launchWelcomeMsg
  yesConfirmOrAbort
  launchInstalator_packages
}

launchWelcomeMsg() {
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce} - Installation script"
  echoIt "$_pDel" "Used variables:"
  echoIt "$_pDel" "  - home dir:           ${_cy}$HOME${_ce}"
  echoIt "$_pDel" "  - dotfiles repo:      ${_cy}$dotfilesPath${_ce}"
}

launchInstalator_packages() {
  echoIt
  showMenuOptions
  local chosenOption=$(readMenuOptionInput)
  execMenuOption $chosenOption
}

# menu:
declare -a menuOptions=( \
  "   [ ${_cy}1${_ce} ] Install all configs [enter]" \
  "   [ ${_cy}2${_ce} ] Delete all the configs installed" \
  "   [ ${_cy}3${_ce} ] Skip packages installation and change only environment value." \
  "   [ ${_cy}4${_ce} ] View all QYADR's packages" \
  "   [ ${_cy}5${_ce} ] Show manual install/uninstall commands" \
  "   [ ${_cy}6${_ce} ] Quit"
)

showMenuOptions() {
  echoIt "$_pDel" "- [ Choose one of the options bellow: ] ---------------" "${_ia}"
  for OPTION in "${menuOptions[@]}" ; do
    echoIt "$_pDel" "${OPTION}"
  done
}

readMenuOptionInput() {
  read  -n 1 -r -p "${_pDel}    Enter your choice: ${_cb}>${_ce} "
  echo >&2
  echo ${REPLY:-1}
}

execMenuOption() {
  local choice=$1
  local menuOptionTxt=${menuOptions[${choice}-1]}
  if [[ "$choice" == 1 ]] ; then
    yesConfirmOrAbort "Ready to: $menuOptionTxt"
    stowAll
    copyExamples
    echoIt "$_pDel" "Installed all dotfiles in home directory."
    echoDone
    launchInstalator_envPackage
    reloadMsgAfterStowAll
  elif [[ "$choice" == 2 ]] ; then
    yesConfirmOrAbort "Ready to: $menuOptionTxt" \
      && unstowAll
    echoIt "$_pDel" "Uninstalled all dotfiles in home directory."
    echoDone
  elif [[ "$choice" == 3 ]] ; then
    launchInstalator_envPackage
  elif [[ "$choice" == 4 ]] ; then
    showPackages
    showEnvPackages
    launchInstalator_packages
  elif [[ "$choice" == 5 ]] ; then
    showManualCommands
    quitMenu
  else
    quitMenu
  fi
}

quitMenu() {
    echoIt "$_pDel" "Quitting script!" "${_ic}"
    exit 0
}

showPackages() {
  echoIt "$_pDel" "List of packages:"
  for pack in "${packs[@]}" ; do
    echoIt "$_pDel" " - ${pack}"
  done
}

showManualCommands() {
  echoIt "$_pDel" "Manual commands:"
  echoIt "$_pDel" "stow -vt ~ -d .qyadr <package-name> # installation"
  echoIt "$_pDel" "stow -vt ~ -d .qyadr -D <package-name> # remove"
}

stowAll() {
  for pack in "${packs[@]}" ; do
    if isDir "$dotfilesPath/$pack" ; then
      stow -vd ${dotfilesPath} -S ${pack} -t ${HOME}
      echoIt "$_pDel" "Stowed package name: ${_cy}${pack}${_ce}" "$_it"
    else
      errorExit_stowError ${pack}
    fi
  done
}

copyExamples(){
  echoIt "$_pDel" "About to copy example files..."
  copyExample_config
}

copyExample_config() {
  local filePath="${HOME}/.qyadr-config.example"
  local destPath=${filePath%%.example}
  if isFile ${filePath} ; then
    cp -f $filePath $destPath
    echoIt "$_pDel" "   ...  ${filePath} -> ~/${_cy}${destPath}${_ce}"
  else
    warnNotFound $filePath
  fi
}

warnNotFound() {
  echoIt "$_pDel" "${_cy}Warn:${_ce} file found file: ${1} ! Maybe not stowed?" "${_iw}"
}

reloadMsgAfterStowAll() {
  echoIt "$_pDel" "${_cy}Warn: login again to apply changes!${_ce}" "${_iw}"
}

errorExit_stowError() {
  echoIt "${_pDel}" "Cannot stowed package name: $1 (Is this correct name?)" "$_iw"
  errorExit "$_pDel" "Aborting script!"
}

unstowAll() {
  renameBashrc
  unstowPackages
  unstowEnvsAll
}

unstowPackages() {
  for pack in "${packs[@]}" ; do
    if isDir "$dotfilesPath/$pack" ; then
      stow -vd ${dotfilesPath} -D ${pack} -t ${HOME}
      echoIt "$_pDel" "Unstowed package name: ${_cy}${pack}${_ce}" "$_it"
    fi
  done
}

unstowEnvsAll() {
  for env in "${envPackagesList[@]}" ; do
    local envDir="_${env}"
    local envDirPath="${dotfilesPath}/${envDir}"
    if isDir "$envDirPath" ; then
      stow -vd ${dotfilesPath} -D ${envDir} -t ${HOME}
      echoIt "$_pDel" "Unstowed env package name: ${_cy}${envDir}${_ce}" "$_it"
    fi
  done
}

# env installation
launchInstalator_envPackage() {
  launchEnvWelcome
  showMenuOptionsEnv
  local chosenOption=$(readMenuOptionInput)
  execMenuOptionEnv $chosenOption
}

launchEnvWelcome() {
  echoIt "$_pDel" "It's time to install packages for specific linux environmen..."
  echoIt "$_pDel" "   ... default environment is:  ${_cy}$defaultEnvValue${_ce}"
}

# menu:
declare -a menuOptionsEnv=( \
  "   [ ${_cy}1${_ce} ] Yep! Proceed. [enter]" \
  "   [ ${_cy}2${_ce} ] Change it." \
  "   [ ${_cy}3${_ce} ] View all QYADR's environment packages" \
  "   [ ${_cy}4${_ce} ] No. Skip it!" \
)

showMenuOptionsEnv() {
  echoIt "$_pDel" "- [ Choose one of the options bellow: ] ---------------" "${_ia}"
  for OPTION in "${menuOptionsEnv[@]}" ; do
    echoIt "$_pDel" "${OPTION}"
  done
}

execMenuOptionEnv() {
  local choice=$1
  local menuOptionTxt=${menuOptionsEnv[${choice}-1]}
  if [[ "$choice" == 1 ]] ; then
    yesConfirmOrAbort "Ready to: $menuOptionTxt" \
      && stowEnv # default environment
    echoDone
  elif [[ "$choice" == 2 ]] ; then
    launchChange_envPackage
  elif [[ "$choice" == 3 ]] ; then
    showEnvPackages
    launchInstalator_envPackage
  else
    echoDone
  fi
}

showEnvPackages() {
  echoIt "$_pDel" "List of environment packages:"
  for pack in "${envPackagesList[@]}" ; do
    echoIt "$_pDel" " - ${pack}"
  done
}

stowEnv() {
  local envPackName="${1:-"$defaultEnvValue"}"
  local envPackDirName="_${envPackName}"
  local envDir="${dotfilesPath}/${envPackDirName}"
  if isDir "$envDir" ; then
    renameBashrc
    stow -vd ${dotfilesPath} -S ${envPackDirName} -t ${HOME}
    echoIt "$_pDel" "Stowed package name: ${_cy}${envPackDirName}${_ce}" "$_it"
  else
    errorExit_stowError ${envPackDirName}
  fi
}

# env change
launchChange_envPackage() {
  echoIt
  launchChangeEnvWelcome
  showMenuOptionsEnvChange
  local chosenOption=$(readMenuOptionInput)
  execChangeEnv $chosenOption
}

launchChangeEnvWelcome() {
  echoIt "$_pDel" "Changing environment package..."
}

showMenuOptionsEnvChange() {
  echoIt "$_pDel" "- [ Choose one of the options bellow: ] ---------------" "${_ia}"
  for idx in "${!envPackagesList[@]}" ; do
    local nbr="[ ${_cy}$((idx + 1))${_ce} ]"
    echoIt "$_pDel" "   ${nbr} - ${envPackagesList[$idx]}"
  done
}

execChangeEnv() {
  local choice=$1
  local choiceCorrect=$((choice - 1))
  local choiceName="${envPackagesList[choiceCorrect]}"
  yesConfirmOrAbort "Ready to change environment to: ${_cy}${choice}${_ce} ?"
  renameBashrc
  unstowEnvsAll
  stowEnv $choiceName
  changeEnvValueInConfig $choiceName
  echoDone
}

changeEnvValueInConfig() {
  local changedValue=$1
  sed -i "s/\(^.*QYADR_ENV=\).*/\1'${changedValue}'/" "${HOME}/.qyadr-config"
}

renameBashrc() {
  # Avoid stow conflict
  if isFile "${HOME}/.bashrc" ; then
    mv .bashrc{,.back}
  fi
}

main "$@"