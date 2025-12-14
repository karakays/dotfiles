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

-- Folding (treesitter-based)
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevel = 99  -- start with all folds open
set.foldenable = true

-- Use indent-based folding for JSON/XML (treesitter folds are flat for these)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "xml" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
})

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
set.directory = vim.fn.expand('~') .. '/.vim/swap//'
set.backupdir = vim.fn.expand('~') .. '/.vim/backup//'

-- Enable syntax highlighting
vim.opt.termguicolors = true
vim.cmd('syntax enable')

