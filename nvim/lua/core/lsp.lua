-- core/lsp.lua

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global LSP keybindings - triggers for ANY LSP that attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP attached: " .. client.name)  -- Debug line

    local telescope = require('telescope.builtin')
    local opts = { buffer = bufnr, silent = true }

    -- LSP keybindings with Telescope UI
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
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
  ensure_installed = { "pyright", "jdtls", "ts_ls" },
})

-- Python LSP
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- Java LSP (jdtls)
lspconfig.jdtls.setup({
  capabilities = capabilities,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      configuration = { updateBuildConfiguration = "automatic" },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
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
