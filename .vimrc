syntax enable
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

set nu                                                  " turn on line numbers
set clipboard=unnamed                                   " enable access to system clipboard
set encoding=utf-8
set textwidth=120                                       " break lines after 120 columns
set tabstop=4                                           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4                                        " number  of spaces to use for auto indent
set autoindent                                          " copy indent from current line when starting a new line
set smartindent                                         " use smart indent if there's no indent file
set expandtab                                           " enter spaces when tab is pressed
set number relativenumber
set pastetoggle=<F10>                                   " toggle paste mode

""" Searching

set ignorecase                                          " case insensitive searching
set hlsearch                                            " highlight searching
set smartcase                                           " unless uppercase letters are used in the regex.
set incsearch                                           " enable incremental searching
filetype on                                             " detect file types
set title                                               " show title in console bar
set cursorline                                          " indicate cursor line
set ruler
set scrolloff=3                                         " keep 3 lines of context around cursor position

nnoremap <C-J> <C-W><C-J>                               " windows navigations
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-Left> :tabp<CR>                             " tab navigation
nnoremap <C-Right> :tabn<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim                " ctrlp fuzzy finder
set wildignore+=*.so,*.swp,*.class
set laststatus=2
let g:ctrlp_by_filename = 0                             " let ctrl-p to search by filename rather than path

execute pathogen#infect()                               
set statusline+=%#warningmsg#                           " pathogen
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1            " syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }


set tags=./tags;/                                       " ctags

if exists('$TMUX')                                      " set cursor based on mode
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
