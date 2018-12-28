#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

set -e

# Setup:
readonly dotfilesRepo='https://github.com/qaraluch/qyadr.git'

# Utils:
readonly dotfilesHomeDir='.qyadr'
readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"
readonly purgeScriptPath="${dotfilesPath}/purge.sh"
readonly installScriptPath="${dotfilesPath}/install.sh"
readonly updateScriptPath="${dotfilesPath}/update.sh"
readonly purgeScriptName="${dotfilesHomeDir}-purge.sh"
readonly installScriptName="${dotfilesHomeDir}-install.sh"
readonly updateScriptName="${dotfilesHomeDir}-update.sh"

readonly _pDel='[ QYADR-deploy ]'

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
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce} - Deployment Script (QYADR-DEPLOY)"
  echoIt "$_pDel" "Used variables:"
  echoIt "$_pDel" "  - home dir:                 ${_cy}$HOME${_ce}"
  echoIt "$_pDel" "  - qyadr deployment dir:     ${_cy}${dotfilesHomeDir}${_ce}"
  yesConfirmOrAbort "Ready to roll"

  cleanUps
  echoIt "$_pDel" "Cleaned up old QYADR source dirs from home directory." "$_it"

  cloneDotfilesGitRepo
  echoIt "$_pDel" "Cloned QYADR repo." "$_it"

  copyInstallScript
  echoIt "$_pDel" "Copied install script to home directory for further use." "$_it"

  copyPurgeScript
  echoIt "$_pDel" "Copied purge script to home directory for further use." "$_it"

  copyUpdateScript
  echoIt "$_pDel" "Copied update script to home directory for further use." "$_it"

  echoDone
}

cleanUps() {
  if isDir ${dotfilesPath} ; then
    rm -rf ${dotfilesPath}
  fi
}

cloneDotfilesGitRepo() {
  isDir  "$HOME/${dotfilesHomeDir}" || \
    git clone --depth 1 ${dotfilesRepo} ${dotfilesHomeDir}
}

copyInstallScript() {
  if isFile ${installScriptPath} ; then
    local finalDest="${HOME}/${installScriptName}"
    cp "${installScriptPath}" ${finalDest}
    chmod u+x ${finalDest}
  fi
}

copyPurgeScript() {
  if isFile ${purgeScriptPath} ; then
    local finalDest="${HOME}/${purgeScriptName}"
    cp "${purgeScriptPath}" ${finalDest}
    chmod u+x ${finalDest}
  fi
}

copyUpdateScript() {
  if isFile ${updateScriptPath} ; then
    local finalDest="${HOME}/${updateScriptName}"
    cp "${updateScriptPath}" ${finalDest}
    chmod u+x ${finalDest}
  fi
}

main