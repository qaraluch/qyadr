# Locate database
# creation, update and remove scripts
# tailored for WSL

export QYADR_LOCATE_DIR="${HOME}/.locate-dbs"

locate-update-dbs() {
  _echoIt "$_QDel" "About to ${_cy}update${_ce} locate database..."
  if _isNotDir $QYADR_LOCATE_DIR ; then
    mkdir $QYADR_LOCATE_DIR
    [[ $? ]] && _echoIt "$_QDel" "Created locate database directory: ${_cy}${QYADR_LOCATE_DIR}${_ce}"
  fi
  _locate-update-db-home
  _locate-update-db-config
  _locate-update-db-qnb
  _locate-update-db-dev
  _locate-update-db-dropbox
}

locate-remove-dbs() {
  _echoIt "$_QDel" "About to ${_cy}remove${_ce} locate database..."
  rm -rf $QYADR_LOCATE_DIR
  _echoDone
}

_locate-update-db-home() {
  local sourcePath="${HOME}"
  local sourceName='home'
  if _isDir ${sourcePath} ; then
    command updatedb -l 0 -U "${sourcePath}/" -o "${QYADR_LOCATE_DIR}/${sourceName}.db"
    __update-updatedMsg $sourceName
  else
    __update-warnNotFound $sourcePath
  fi
}

_locate-update-db-config() {
  local sourcePath="${WSL_WIN_CONFIG}"
  local sourceName='config'
  if _isDir ${sourcePath} ; then
    command updatedb -l 0 -U "${sourcePath}/" -o "${QYADR_LOCATE_DIR}/${sourceName}.db"
    __update-updatedMsg $sourceName
  else
    __update-warnNotFound $sourcePath
  fi
}

_locate-update-db-qnb() {
  local sourcePath1="${WSL_QNNB}"
  local sourceName1='qnb'
  if _isDir ${sourcePath1} ; then
    command updatedb -l 0 -U "${sourcePath1}/" -o "${QYADR_LOCATE_DIR}/${sourceName1}.db"
    __update-updatedMsg $sourceName1
  else
    __update-warnNotFound $sourcePath1
  fi
}

_locate-update-db-dev() {
  local sourcePath="${WSL_WIN_DEV}"
  local sourceName='dev'
  if _isDir ${sourcePath} ; then
    command updatedb -l 0 -U "${sourcePath}/" -o "${QYADR_LOCATE_DIR}/${sourceName}.db"
    __update-updatedMsg $sourceName
  else
    __update-warnNotFound
  fi
}

_locate-update-db-dropbox() {
  local sourcePath="${WSL_WIN_DROPBOX}"
  local sourceName='dropbox'
  if _isDir ${sourcePath} ; then
    command updatedb -l 0 -U "${sourcePath}/" -o "${QYADR_LOCATE_DIR}/${sourceName}.db"
    __update-updatedMsg $sourceName
  else
    __update-warnNotFound
  fi
}

locate-get-data() {
  echo "$(locate -d "${QYADR_LOCATE_DIR}/home.db" \
  -d "${QYADR_LOCATE_DIR}/config.db" \
  -d "${QYADR_LOCATE_DIR}/qnb.db" \
  -d "${QYADR_LOCATE_DIR}/dev.db" \
  -d "${QYADR_LOCATE_DIR}/dropbox.db" \
  /)" |\
  grep -vE 'git|local|vim|npm|cache|mozilla|tmux/resurrect|workspaceStorage'
}

__update-updatedMsg(){
  _echoIt "${_QDel}" "  ... updated: ${_cy}${1}${_ce}${_ce}.db" "${_it}"
}

__update-warnNotFound(){
  _echoIt "${_QDel}" "[ ${_cy}!${_ce} ] Not found dir: ${1}" "${_iw}"
}
