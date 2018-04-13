""" UI settings

" turn on relative line numbers
set number relativenumber
" enable access to system clipboard
set clipboard=unnamed
set encoding=utf-8
" break lines after 120 columns
set textwidth=120
" use 4 spaces to represent tab
set tabstop=4
set softtabstop=4
" number  of spaces to use for auto indent
set shiftwidth=4
" copy indent from current line when starting a new line
set autoindent
" use smart indent if there's no indent file
set smartindent
" enter spaces when tab is pressed
set expandtab
" toggle paste mode
set pastetoggle=<F10>                                   
" always show status bar
set laststatus=2
" visual auto-complete menu
set wildmenu

" Colorscheme

set background=dark
let g:solarized_termcolors=16
colorscheme solarized
syntax enable

""" Searching

" case insensitive searching
set ignorecase
" highlight searching
set hlsearch
" unless uppercase letters are used in the regex.
set smartcase
" enable incremental searching
set incsearch
" detect file type and indent
filetype plugin indent on
" show title in console bar
set title
" indicate cursor line
set cursorline
set ruler
" lines of context around cursor position
set scrolloff=3
set viminfo+=n~/.vim/.viminfo

""" Mappings

noremap <Left>  <nop>
noremap <Right> <nop>
noremap <Up>    <nop>
noremap <Down>  <nop>

nnoremap 0 ^
noremap $ g_

inoremap jk    <esc>
inoremap <esc> <nop>

" windows navigation
nnoremap <C-J> <C-W>J
nnoremap <C-K> <C-w>K
nnoremap <C-L> <C-W>L
nnoremap <C-H> <C-W>H

" Save
nnoremap s :w<cr>

" Quit
nnoremap q :q<cr>

" Soft quit
nnoremap Q :q!<cr>

" Blank lines on enter
nnoremap <cr> o<esc>

""" Leader
let mapleader=","

""" Quick editing
nnoremap <leader>ev :split ~/.vim/.vimrc<cr>

""" Syntax check
nnoremap <leader>C :SyntasticCheck<cr>


" NERD Tree {{{
noremap  <leader>nt :NERDTreeToggle<cr>
inoremap <leader>nt <esc>:NERDTreeToggle<cr>
noremap  <leader>nf :NERDTreeFind<cr>
inoremap <leader>nf <esc>:NERDTreeFind<cr>

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['\~$', '.*\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" }}}

" Python-Mode {{{
let g:pymode_python = 'python3'

" }}}


" Fugitive {{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gci :Gcommit<cr>

" }}}

""" Abbreviations
iabbrev @@ skarakayali@gmail.com
iabbrev nname Selçuk Karakayalı

autocmd InsertLeave * :echo 'Left insert mode'

" ctags
set tags=./tags;/

" set cursor based on mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" CtrlP settings ---------------------- {{{
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*.so,*.swp,*.class
" search by filename rather than path
let g:ctrlp_by_filename = 0
" }}}

" Syntastic settings ---------------------- {{{
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_mode_map={ 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

" disable python-mode
" call add(g:pathogen_disabled, 'python-mode')
" Pathogen
execute pathogen#infect()
