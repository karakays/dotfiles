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

-- Leader key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Quit (q preserved for macros)
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Quit' })

-- Blank lines on enter
vim.keymap.set('n', '<leader><CR>', 'o<esc>', { noremap = true, silent = true, desc = 'Blank line below' })

-- Swap direction word occr
map('n', '*', '#', opts)
map('n', '#', '*', opts)

-- Open all folds
vim.keymap.set('n', 'zO', 'zR', { noremap = true, silent = true, desc = 'Open all folds' })

-- Tab mappings
vim.keymap.set('n', 'tk', ':tabnext<CR>',  { noremap = true, silent = true, desc = 'Next tab' })
vim.keymap.set('n', 'tj', ':tabprev<CR>',  { noremap = true, silent = true, desc = 'Previous tab' })
vim.keymap.set('n', 't0', ':tabfirst<CR>', { noremap = true, silent = true, desc = 'First tab' })
vim.keymap.set('n', 't9', ':tablast<CR>',  { noremap = true, silent = true, desc = 'Last tab' })
vim.keymap.set('n', 'tn', ':tabedit<CR>',  { noremap = true, silent = true, desc = 'New tab' })
vim.keymap.set('n', 'tq', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close tab' })

-- Clear hlsearch (Esc in normal mode is unused by default)
vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })

-- Delete to end of line
vim.keymap.set('n', 'D', 'd$', { noremap = true, silent = true, desc = 'Delete to end of line' })

-- Marks
vim.keymap.set('n', '`', ':<C-u>marks<CR>:normal! `', { noremap = true, silent = true, desc = 'Pick mark' })

-- Config editing
vim.keymap.set('n', '<leader>ve', ':split $MYVIMRC<CR>',  { noremap = true, silent = true, desc = 'Edit config' })
vim.keymap.set('n', '<leader>vs', ':source $MYVIMRC<CR>', { noremap = true, silent = true, desc = 'Source/reload config' })

-- LSP format on demand
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = 'LSP Format' })

-- Document symbols (outline)
vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true, silent = true, desc = 'Document Symbols' })


