#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

set -e

# Setup:
declare -a packs=( \
  zsh \
  functions \
  aliases \
  scripts \
  git \
  _wsl \
)

readonly qyadrEnvDefault='wsl'

# Utils:
readonly dotfilesHomeDir='.qyadr'
readonly qyadrEnvFile='.qyadr-env'

readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"

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

echoDone() {
  echoIt "$_pDel" "DONE!" "$_it" ; echo >&2
}

errorExit_abortScript() {
  errorExit "$_pDel" "Aborting script!"
}

# Main:
main() {
  local env=${2:-$qyadrEnvDefault}
  if isStringEmpty "$@" ; then
    # If args is passed to the script run auto mode
    # otherwise launch interactive one with menu.
    runMainInteractive
  else
    runMainAuto $1 $env
  fi
}

# auto path
runMainAuto() {
  local choice=$1
  local env=$2
  local envParsed=$(parseEnvInput ${env} ${qyadrEnvDefault})
  if [[ "$choice" == 1 ]] ; then
    stowAll
    saveEnvToFile $envParsed
  elif [[ "$choice" == 2 ]] ; then
    unstowAll
  else
    quitMenu
  fi
}

parseEnvInput() {
  local input=$1
  local default=$2
  case $input in
    wsl)
    echo $input
    ;;
    vb)
    echo $input
    ;;
    linux)
    echo $input
    ;;
    *)
    echo $default
    ;;
  esac
}

saveEnvToFile() {
  local env=$1
  echo $env > "${qyadrEnvFile}"
}

# interactive path
runMainInteractive() {
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce} installation script"
  echoIt "$_pDel" "Used variables:"
  echoIt "$_pDel" "  - home dir:           ${_cy}$HOME${_ce}"
  echoIt "$_pDel" "  - dotfiles repo:      ${_cy}$dotfilesPath${_ce}"
  yesConfirmOrAbort
  launchMenu
}

launchMenu() {
  echoIt
  showMenuOptions
  local chosenOption=$(readMenuOptionInput)
  execMenuOption $chosenOption
}

# menu:
declare -a menuOptions=( \
  "   [ ${_cy}1${_ce} ] Install all configs" \
  "   [ ${_cy}2${_ce} ] Delete all the configs installed" \
  "   [ ${_cy}3${_ce} ] View all QYADR's packages" \
  "   [ ${_cy}4${_ce} ] Show manual install/uninstall commands" \
  "   [ ${_cy}5${_ce} ] Quit" \
)

showMenuOptions() {
  echoIt "$_pDel" "---[ Choose one of the options bellow: ] ---------------" "${I_A}"
  for OPTION in "${menuOptions[@]}" ; do
    echoIt "$_pDel" "${OPTION}"
  done
}

readMenuOptionInput() {
  read  -n 1 -r -p "${_pDel}    Enter your choice: ${_cb}>${_ce} "
  echo >&2
  echo ${REPLY}
}

execMenuOption() {
  local choice=$1
  local menuOptionTxt=${menuOptions[${choice}-1]}
  if [[ "$choice" == 1 ]] ; then
    yesConfirmOrAbort "Ready to: ${_cy}$menuOptionTxt${_ce}" \
      && stowAll
    echoIt "$_pDel" "Installed all dotfiles in home directory."
    setupEnvInteractive
    echoDone
  elif [[ "$choice" == 2 ]] ; then
    yesConfirmOrAbort "Ready to: ${_cy}$menuOptionTxt${_ce}" \
      && unstowAll
    echoIt "$_pDel" "Uninstalled all dotfiles in home directory."
    echoDone
  elif [[ "$choice" == 3 ]] ; then
    showPackages
    launchMenu
  elif [[ "$choice" == 4 ]] ; then
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
      stow -vd ${dotfilesPath} -S ${pack} -t ${home}
      echoIt "$_pDel" "Stowed package name: ${_cy}${pack}${_ce}" "$_it"
    else
      errorExit_stowError ${pack}
    fi
  done
  echoIt "$_pDel" "${_cy}Warn: source .zshrc to see changes!${_ce}" "${_iw}"
}

errorExit_stowError() {
  echoIt "${_pDel}" "Cannot stowed package name: $1 (Is this correct name?)" "$_iw"
  errorExit "$_pDel" "Aborting script!"
}

unstowAll() {
  for pack in "${packs[@]}" ; do
    if isDir "$dotfilesPath/$pack" ; then
      stow -vd ${dotfilesPath} -D ${pack} -t ${HOME}
      echoIt "$_pDel" "Unstowed package name: ${_cy}${pack}${_ce}" "$_it"
    fi
  done
}

setupEnvInteractive() {
  local msg="Choose for witch environment install qyadr: ${_cy}${qyadrEnvDefault}${_ce} [enter] or ${_cy}vb${_ce} or ${_cy}linux${_ce} ?"
  local choice=$(inputWithDefault "${msg}" ${qyadrEnvDefault})
  local parsed=$(parseEnvInput ${choice} ${qyadrEnvDefault})
  saveEnvToFile $parsed
  echoIt "$_pDel" "Saved environment variable: ${_cy}${parsed}${_ce}, to the file: ${qyadrEnvFile}"
}

inputWithDefault() {
  local msg=$1
  local default=$2
  read -r -p "${_pDel}${_ia} $msg "
  if  isStringEmpty $REPLY ; then
    echo  $default
  else
    echo $REPLY
  fi
}

main "$@"