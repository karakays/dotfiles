syntax enable
" This stupid line is necessary otherwise solarized shows ugly
"let g:solarized_termtrans=1
let g:solarized_termcolors=256
set background=dark
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" solarized color scheme at ~/.vim/colors/solarized.vim
colorscheme solarized
" highlight searching
set hlsearch
" enable incremental searching
set incsearch
" turn on line numbers
set nu
" enable access to system clipboard
set clipboard=unnamed
set encoding=utf-8
" enter spaces when tab is pressed
set expandtab           
" break lines when line length increases
set textwidth=120       
" use 4 spaces to represent tab
set tabstop=4           
set softtabstop=4
" number of spaces to use for auto indent
set shiftwidth=4        
" copy indent from current line when starting a new line
set autoindent          

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab navigation
nnoremap <C-Left> :tabp<CR>
nnoremap <C-Right> :tabn<CR>

" ctrlp fuzzy finder
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*.so,*.swp,*.class
set laststatus=2

" pathogen
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['java'] }

"ctags
set tags=./tags;/
