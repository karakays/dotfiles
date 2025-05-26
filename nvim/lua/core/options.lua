-- core/options.lua

local set = vim.opt

-- UI settings
set.number = true
set.relativenumber = true

-- Enable system clipboard
if vim.fn.has('macunix') == 1 then
  set.clipboard = 'unnamed'
else
  set.clipboard = 'unnamedplus'
end

set.encoding = 'utf-8'
set.textwidth = 120
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.smartindent = true
set.expandtab = true
--set.pastetoggle = '<F10>'

-- Status line and visual enhancements
set.laststatus = 2
set.wildmenu = true
set.title = true
set.cursorline = true
set.ruler = true
set.scrolloff = 3
set.history = 200
set.splitright = true
set.splitbelow = true

-- Searching
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.grepprg = 'rg -i --vimgrep'
set.grepformat = '%f:%l:%c:%m'

-- Autocompletion
--set.filetype = 'plugin indent on'

-- Swap and backup directories
set.directory = '~/.vim/swap//'
set.backupdir = '~/.vim/backup//'

-- Enable syntax highlighting
vim.opt.termguicolors = true
vim.cmd('syntax enable')

