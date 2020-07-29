" Neovim config entry point
" Main config is placed in old-vim file ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
