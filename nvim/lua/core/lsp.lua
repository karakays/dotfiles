-- core/lsp.lua

-- Mason setup (install LSPs easily)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "jdtls" }, -- install pyright and jdtls automatically
})

-- LSP setup
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- Java LSP (jdtls) setup
-- Auto-configure jdtls on Java file open with project-specific workspace
local home = os.getenv("HOME")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    -- Get project root directory
    local root_dir = lspconfig.util.root_pattern(
      ".git",
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "settings.gradle",
      "settings.gradle.kts"
    )(vim.fn.expand("%:p"))

    -- Create project-specific workspace directory
    local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

    local config = {
      cmd = {
        "jdtls",
        "-data", workspace_dir
      },
      root_dir = root_dir,
      capabilities = capabilities,
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          maven = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "automatic",
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
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
      on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      end,
    }

    lspconfig.jdtls.setup(config)
    vim.cmd("LspStart")
  end,
})
