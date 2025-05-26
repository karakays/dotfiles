-- core/lsp.lua

-- Mason setup (install LSPs easily)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" }, -- install pyright automatically
})

-- LSP setup
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({
  capabilities = capabilities,
})
