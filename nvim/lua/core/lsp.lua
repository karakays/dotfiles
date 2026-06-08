-- core/lsp.lua

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function lsp_definitions()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/definition" })
  if #clients == 0 then
    vim.notify("No LSP definition provider attached to this buffer", vim.log.levels.WARN)
    return
  end

  require("telescope.builtin").lsp_definitions()
end

-- Diagnostic display configuration
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Force diagnostic underline highlights (gruvbox doesn't set these properly)
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#fb4934' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = '#fabd2f' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = '#83a598' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = '#8ec07c' })

vim.keymap.set('n', 'gd', lsp_definitions, { silent = true, desc = 'Go to definition' })

-- Global LSP keybindings - triggers for ANY LSP that attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    local telescope = require('telescope.builtin')
    local opts = { buffer = bufnr, silent = true }

    -- LSP keybindings with Telescope UI
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Call hierarchy
    vim.keymap.set('n', '<leader>ci', telescope.lsp_incoming_calls, opts)  -- who calls this?
    vim.keymap.set('n', '<leader>co', telescope.lsp_outgoing_calls, opts)  -- what does this call?
  end,
})

-- Mason setup (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "jdtls", "ts_ls", "gopls" },
})

-- Python LSP
lspconfig.pyright.setup({
  capabilities = capabilities,
})

require("core.lsp.java").setup(lspconfig, capabilities)

-- Go LSP (gopls)
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- TypeScript/JavaScript LSP
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})
