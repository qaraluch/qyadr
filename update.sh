#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

set -e

# Setup:

# Utils:
readonly dotfilesHomeDir='.qyadr'
readonly dotfilesPath="${HOME}/${dotfilesHomeDir}"
readonly purgeScriptPath="${dotfilesPath}/purge.sh"
readonly installScriptPath="${dotfilesPath}/install.sh"
readonly updateScriptPath="${dotfilesPath}/update.sh"
readonly purgeScriptName="${dotfilesHomeDir}-purge.sh"
readonly installScriptName="${dotfilesHomeDir}-install.sh"
readonly updateScriptName="${dotfilesHomeDir}-update.sh"

readonly _pDel='[ QYADR-update ]'

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
  echoIt "$_pDel" "Welcome to: ${_cy}Qaraluch's Yet Another Dotfiles Repo${_ce} - ${_cg}UPDATE${_ce} Script"
  yesConfirmOrAbort "Ready to roll"
  updateRepos
  updateQyadrUtilScripts
  echoIt "$_pDel" "${_cg}QYADR is up-to-date!${_ce}" "$_it"
  echoDone
}

updateRepos() {
  if isDir ${dotfilesPath} ; then
    cd ${dotfilesPath}
    execGitPull
    showGitLogs
    echoIt "$_pDel" "Updated: ${dotfilesHomeDir} repo." "${_it}"
  fi
}

execGitPull() {
  git pull --rebase --stat origin master
}

showGitLogs() {
  local git_log_default_format='%C(auto,yellow)%h - %C(auto,blue)%>(14,trunc) %cd - %C(auto,reset)%s%C(auto,cyan)% gD% %Creset'
  git --no-pager log --pretty=format:"$git_log_default_format" --abbrev-commit --date=relative -10
  echoIt
}

updateQyadrUtilScripts() {
  copyInstallScript
  echoIt "$_pDel" "Copied again install script to home directory." "$_it"

  copyPurgeScript
  echoIt "$_pDel" "Copied again purge script to home directory." "$_it"

  copyUpdateScript
  echoIt "$_pDel" "Copied again update script to home directory." "$_it"
}

copyInstallScript() {
  isFile ${installScriptPath} && \
    cp "${installScriptPath}" "${HOME}/${installScriptName}"
}

copyPurgeScript() {
  isFile ${purgeScriptPath} && \
    cp "${purgeScriptPath}" "${HOME}/${purgeScriptName}"
}

copyUpdateScript() {
  isFile ${updateScriptPath} && \
    cp "${updateScriptPath}" "${HOME}/${updateScriptName}"
}

main