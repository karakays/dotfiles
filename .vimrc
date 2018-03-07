""" UI settings

set background=dark
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
" visual auto-complete menu
set wildmenu
let g:solarized_termcolors=16
colorscheme solarized
syntax enable


""" Abbreviations

iabbrev @@ skarakayali@gmail.com
iabbrev nname Selçuk Karakayalı


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
filetype indent on
" show title in console bar
set title
" indicate cursor line
set cursorline
set ruler
" keep 3 lines of context around cursor position
set scrolloff=3


""" Mappings

noremap <Left>  <nop>
noremap <Right> <nop>
noremap <Up>    <nop>
noremap <Down>  <nop>

" exit insert mode
inoremap jk    <esc>
inoremap <esc> <nop>

" windows navigation
nnoremap <C-J> <C-W>J
nnoremap <C-K> <C-w>K
nnoremap <C-L> <C-W>L
nnoremap <C-H> <C-W>H

autocmd InsertLeave * :echo 'Left insert mode'

" CtrlP settings
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*.so,*.swp,*.class
set laststatus=2
" let ctrl-p to search by filename rather than path
let g:ctrlp_by_filename = 0

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

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Pathogen
execute pathogen#infect()                               
