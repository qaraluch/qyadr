#!/usr/bin/env bash
# Author: qaraluch - 12.2018 - MIT
# Project: QYADR

# Settings:
# readonly installListDefaultPath="${HOME}/.qyadr-install-list.csv"
readonly installListDefaultPath="install-list.csv.example" # !!!!!!!!!!

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

# Errors:
errorExit_abortScript() {
  errorExit "$_pDel" "Aborting script!"
}

errorExit_noInstallListFound() {
  errorExit "$_pDel" "Not found installation list: $1"
}

# CLI:
printUsage() {
  cat <<EOL

  Help:
  ---------
  ${_cy}${_pName}${_ce} - install (stow) qyadr packages.

  Usage:
    ${_pName} ${_cy}ls${_ce}                - show list all packages (except of env ones).
    ${_pName} ${_cy}ls${_ce} [env]          - show only environment packages.


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
  local flag
  local cmd
  local positional=()
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
  echo  "${positional[@]}"
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

# Main exec
main