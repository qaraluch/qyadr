"""""""""""""""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"" insert empty line with no insert mode (vsc)
noremap <leader>o o<Esc>
noremap <leader>O O<Esc>

"" insert empty line and go back (vsc)
noremap <leader><leader>o o<Esc>k
noremap <leader><leader>O O<Esc>j

"" insert empty lines beneath and above and i-mode (vsc)
noremap <leader><leader>go O<Esc>jo<Esc>ki

"" esc remap (vsc)
imap jj <Esc>

"" search and center screen (vsc)
noremap <leader>n nzz
noremap <leader>N Nzz

"" move 5 up/down (vsc)
noremap <leader>k 5k
noremap <leader>j 5j

"" replace word/WORD (vsc)
noremap S ciw<C-r>0<Esc>
noremap gS ciW<C-r>0<Esc>

"" save / save&close / quit without save (vsc)
noremap mm :w<CR>
noremap ZZ :x<CR>
noremap ZQ :q!<CR>

"" paste at the end of line (vsc)
noremap <leader>p A<space><Esc>p

"" paste beneath paragraph (vsc)
noremap <leader><leader>p }p

"" delete action without register (vsc)
noremap <leader>d "_d

"" bash/js function (from function name too) yank / delete (vsc)
"" TODO: rozpracowc to. see qyadr-dev/vim
""noremap <leader>yaf va{o0y
""noremap <leader>yf V/}<CR>y

"""""""""""""""""""""""""""""""""""""""""""""""" SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tabs
filetype plugin indent on
set tabstop=2                                    "" show existing tab with 2 spaces width
set shiftwidth=2                                 "" when indenting with '>', use 2 spaces width
set expandtab                                    "" On pressing tab, insert 2 spaces

"" line numbers
set relativenumber
set number

"" cursor shape in different modes (only arch)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"" etc...
set ff=unix
syntax on                                        "" syntax highlights
set directory^=$HOME/.vim/temp//                 "" swap files dir
set nrformats=                                   "" number format for numbers like 007
""set notimeout
""set ttimeout

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
