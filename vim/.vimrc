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
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug '~/.plugs-cache/fzf/'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }             " need node.js and npm
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/neosnippet.vim'
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
noremap <leader>k 10k
noremap <leader>j 10j

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
nnoremap <C-p> :Files<CR>
nnoremap <C-A-p> :History<CR>
" nnoremap <C-A-l> :Locate

"" fzf - extra key bindings
function! s:copy_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @+ = joined_lines
endfunction

let g:fzf_action = {
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': 'split',
  \ 'ctrl-y': function('s:copy_results'),
  \ }

"" fzf - qnb integration
command! -bang -nargs=? Qnb
  \ call fzf#run(fzf#wrap('qnb-files', {'source': 'ag --follow --ignore .git -g ""', 'dir': '/mnt/g/qnb/'}), <bang>0)

nnoremap gq :Qnb<CR>

"" qnb commands
command Qgs :!qnb git status
command Qgc :!qnb git commit
command -nargs=1 Qc :!qnb create new-note dump <q-args>
command -nargs=* Qa :!qnb add new-topic dump <q-args>

"" edit/reload vimrc
nmap <leader>rce :e ~/.vimrc<CR>
nmap <leader>rcr :so ~/.vimrc<CR><Space>

" buffer navigation
nnoremap <leader>bd :bd<CR>
nnoremap <leader>b :buffer *
nnoremap <S-tab> :b#<CR>
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gl :ls<CR> :ls<CR>:b<Space>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" comments
nmap <C-_> gcc
  "" as ctrl-/

" closing brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
  " use <C-v> in insert mode to escape it and use single char

" paths
" parent dir
inoremap <F3> <C-R>=expand("%:p:h")<CR>
" current file
inoremap <F4> <C-R>=expand("%:p")<CR>

"" prettier
"nmap <Leader>pr <Plug>(Prettier)
"workaround:
nmap <Leader>pr :PrettierCli --write <C-R>=expand("%:p")<CR><CR>:e!<CR>

"" gitgutter
nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk

"" spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
nnoremap <F6> :setlocal spell! spelllang=pl<CR>

"" relatvie line numbers toggle
noremap <F3> :set invrelativenumber<CR>
inoremap <F3> <C-O>:set invrelativenumber<CR>

"" syntax highlighting refresh
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"" for variable change (like global replace)
nnoremap gr *:%s///gc<left><left><left>
nnoremap gR *Ncgn

"" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"" neosnippet key-mappings
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

nnoremap <C-A-k> :NeoSnippetEdit<CR>

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
set bg=dark
set termguicolors     " enable true colors support
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" let ayucolor="light"  " for light version of theme
" colorscheme ayu
" colorscheme nord
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'

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

"" airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"" automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

"" prettier
let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

"" neosinppet
" which disables all runtime snippets
let g:neosnippet#disable_runtime_snippets = { '_' : 1, }

let g:neosnippet#snippets_directory='~/.snippets'

"" gf configuration
:set suffixesadd+=.md
:set path+=/mnt/g/qnb

"" cd util
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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
set updatetime=1000	                             " smaler for git gutter plugin

