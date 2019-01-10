# Open in vscode on WSL
vscode-open() {
local winPath=$( wslpath -w $1 )                  # _wsl/.scripts/
  code ${winPath}
}

