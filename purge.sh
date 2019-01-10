#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

set -e

# Setup:

# Utils:
readonly dotfilesHomeDir='.qyadr'
readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"
readonly deployScriptPath="${HOME}/${dotfilesHomeDir}-deploy.sh"
readonly purgeScriptPath="${HOME}/${dotfilesHomeDir}-purge.sh"
readonly installScriptPath="${HOME}/${dotfilesHomeDir}-install.sh"
readonly updateScriptPath="${HOME}/${dotfilesHomeDir}-update.sh"
readonly envFilePath="${HOME}/${dotfilesHomeDir}-env"
readonly plugsCacheDirPath="${HOME}/.plugs-cache"
readonly configPath="${HOME}/.qyadr-config"

readonly _pDel='[ QYADR-purge ]'

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

echoDone() {
  echoIt "$_pDel" "DONE!" "$_it" ; echo >&2
}

errorExit_abortScript() {
  errorExit "$_pDel" "Aborting script!"
}

# Main:
main() {
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce}  - Purge Script"
  echoIt "$_pDel" "Used variables:"
  echoIt "$_pDel" "  - home dir:               ${_cy}${HOME}${_ce}"
  echoIt "$_pDel" "  - qyadr repo:             ${_cy}${dotfilesPath}${_ce}"
  echoIt "$_pDel" "  - qyadr deploy script:    ${_cy}${deployScriptPath}${_ce}"
  echoIt "$_pDel" "  - qyadr install script:   ${_cy}${installScriptPath}${_ce}"
  echoIt "$_pDel" "  - qyadr purge script:     ${_cy}${purgeScriptPath}${_ce}"
  echoIt "$_pDel" "  - qyadr update script:    ${_cy}${updateScriptPath}${_ce}"
  echoIt "$_pDel" "  - qyadr environment file: ${_cy}${envFilePath}${_ce}"
  echoIt "$_pDel" "  - qyadr plugs cache dir:  ${_cy}${plugsCacheDirPath}${_ce}"
  yesConfirmOrAbort "Ready to roll"

  uninstallPackages
  echoIt "$_pDel" "Uninstalled all QYADR packages." "$_it"

  purgeRepos
  echoIt "$_pDel" "Purged QYADR source dirs from home directory." "$_it"

  purgeUtils
  echoIt "$_pDel" "Purged QYADR util scripts, files and cache dir." "$_it"

  purgeConfig
  echoIt "$_pDel" "Purged QYADR config." "$_it"

  echoDone
}

uninstallPackages() {
  # auto mode of uninstall script
  isFile ~/.qyadr-install.sh && bash ~/.qyadr-install.sh 2
}

purgeRepos() {
  if isDir ${dotfilesPath} ; then
    rm -rf ${dotfilesPath}
  fi
}

purgeUtils() {
  if isFile ${deployScriptPath} ; then
    rm -rf ${deployScriptPath}
  fi
  if isFile ${installScriptPath} ; then
    rm -rf ${installScriptPath}
  fi
  if isFile ${purgeScriptPath} ; then
    rm -rf ${purgeScriptPath}
  fi
  if isFile ${updateScriptPath} ; then
    rm -rf ${updateScriptPath}
  fi
  if isFile ${envFilePath} ; then
    rm -rf ${envFilePath}
  fi
  if isDir ${plugsCacheDirPath} ; then
    rm -rf ${plugsCacheDirPath}
  fi
}

purgeConfig() {
  if isFile ${configPath} ; then
    rm -f ${configPath}
  fi
}

main