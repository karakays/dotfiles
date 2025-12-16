-- core/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Disable arrow keys
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)

-- Scroll down/up
map('n', '<C-j>', '<C-e>', opts)
map('n', '<C-k>', '<C-y>', opts)

-- Line movement
map('n', '0', '^', opts)
map('n', '$', 'g_', opts)

-- Toggle mode
map('i', 'jk', '<Esc>', opts)
map('i', '<Esc>', '<Nop>', opts)

-- Window navigation
-- map('n', '<C-J>', '<C-W>J', opts)
-- map('n', '<C-K>', '<C-w>K', opts)
-- map('n', '<C-L>', '<C-W>L', opts)
-- map('n', '<C-H>', '<C-W>H', opts)

-- Save
map('n', 's', ':w<CR>', opts)

-- Quit
map('n', 'q', ':q<CR>', opts)

-- Soft quit
-- map('n', 'Q', ':q!<CR>', opts)

-- Blank lines on enter
map('n', '<CR>', 'o<esc>', opts)

-- Quickfix <CR> mapping
vim.cmd([[autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>]])

-- Swap direction word occr
map('n', '*', '#', opts)
map('n', '#', '*', opts)

-- Open all folds
map('n', 'zO', 'zR', opts)

-- Tab mappings
map('n', 'tk', ':tabnext<CR>', opts)
map('n', 'tj', ':tabprev<CR>', opts)
map('n', 't0', ':tabfirst<CR>', opts)
map('n', 't9', ':tablast<CR>', opts)
map('n', 'tn', ':tabedit<CR>', opts)
map('n', 'tq', ':tabclose<CR>', opts)

-- Copy to clipboard
map('v', '<C-c>', ':w !pbcopy<CR><CR>', opts)

-- Paste
map('i', '<C-v>', ':r !pbpaste<CR><CR>', opts)

-- Clear hlsearch
map('n', '<Space>', ':noh<CR><CR>', opts)

-- Delete to end of line
map('n', 'D', 'd$', opts)

-- Marks
map('n', '`', ':<C-u>marks<CR>:normal! `', opts)

-- Leader key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Config editing
map('n', '<leader>ve', ':split $MYVIMRC<CR>', opts)
map('n', '<leader>vs', ':source $MYVIMRC<CR><Bar>:AirlineRefresh<CR><Bar>:CtrlPClearAllCaches<CR><Bar>:NERDTreeFocus<cr>gg:NERDTreeRefreshRoot<CR><c-w><c-p>', opts)

-- Syntax check
map('n', '<leader>C', ':SyntasticCheck<CR>', opts)

-- Syntastic settings
map('n', '<leader>s', ':SyntasticCheck<CR>', opts)

-- LSP format on demand
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = 'LSP Format' })

-- Document symbols (outline)
vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true, silent = true, desc = 'Document Symbols' })


