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
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'ayu-theme/ayu-vim'
Plug '~/.plugs-cache/fzf/'
Plug 'junegunn/fzf.vim'
call plug#end()

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

"" fzf - find file
nnoremap <C-p> :Files<Cr>
nnoremap <C-S-p> :History<Cr>
nnoremap <C-S-l> :Locate

"" edit/reload vimrc
nmap <leader>rce :e ~/.vimrc<CR>
nmap <leader>rcr :so ~/.vimrc<CR><Space>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

"" bash/js function (from function name too) yank / delete (vsc)
"" TODO: rozpracowc to. see qyadr-dev/vim
""noremap <leader>yaf va{o0y
""noremap <leader>yf V/}<CR>y

"""""""""""""""""""""""""""""""""""""""""""""""" SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tabs
filetype plugin indent on
set tabstop=2                                    " show existing tab with 2 spaces width
set shiftwidth=2                                 " when indenting with '>', use 2 spaces width
set expandtab                                    " on pressing tab, insert 2 spaces

"" line numbers
set relativenumber
set number

"" cursor shape in different modes (only arch)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"" colors & themes
set bg=light
set termguicolors     " enable true colors support
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" let ayucolor="light"  " for light version of theme
colorscheme ayu

"" save views and folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

"" simple sessions manage setup (no plugin)
if !isdirectory($HOME.'/.vim-sessions')
    silent call mkdir ($HOME.'/.vim-sessions', 'p')
endif

let g:sessions_dir = '~/.vim-sessions'

exec 'nnoremap ZS :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap ZR :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

autocmd VimLeave * mks! ~/.vim-sessions/shutdown-session.vim                " automatically save the current session whenever vim is closed

"" clipboard for wsl
set clipboard=unnamedplus

"" etc...
set ff=unix
syntax on                                        " syntax highlights
set directory^=$HOME/.vim/temp//                 " swap files dir
set nrformats=                                   " number format for numbers like 007
""set notimeout
""set ttimeout
set splitbelow splitright	                       " splits open at the bottom and right, which is non-retarded, unlike vim defaults.
autocmd BufWritePre * %s/\s\+$//e                " automatically deletes all trailing whitespace on save.
set encoding=utf-8
set wildmenu	                                   " nvim has it so only for vim compatibility
set wildmode=full
