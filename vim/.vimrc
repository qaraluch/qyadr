"""""""""""""""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"" empty lines with no insert mode
noremap oo o<Esc>k
noremap OO O<Esc>j

"""""""""""""""""""""""""""""""""""""""""""""""" SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tabs
filetype plugin indent on
set tabstop=2                                    "" show existing tab with 2 spaces width
set shiftwidth=2                                 "" when indenting with '>', use 2 spaces width
set expandtab                                    "" On pressing tab, insert 2 spaces

"" line numbers
set relativenumber
set number


"" etc
set ff=unix
syntax on                                        "" syntax highlights
set directory^=$HOME/.vim/temp//                 "" swap files dir
set nrformats=                                   "" number format for numbers like 007

"""""""""""""""""""""""""""""""""""""""""""""""" PLUGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" auto-install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" init plugins
call plug#begin('~/.vim/plugged')
Plug 'plasticboy/vim-markdown'
call plug#end()
