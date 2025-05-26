-- Use with lazy.nvim (https://github.com/folke/lazy.nvim)
return {
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup()

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      end,
  },

  -- Kotlin Syntax Highlighting (still useful)
  {
    "udalov/kotlin-vim"
  },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    -- Toggle the NvimTree window
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    -- Focus on NvimTree window (if open)
    vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })
    -- Open NvimTree in the current file's directory
    vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end,
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Git integration (Fugitive still works great!)
  {
    "tpope/vim-fugitive",
    config = function()
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true, desc = "" }
        keymap("n", "<leader>gs", ":Git<CR>",     { desc = "Git status" })
      end,
  },

  -- Statusline replacement for airline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "gruvbox_light",
          icons_enabled = true,
          section_separators = '',
          component_separators = ''
        }
      }
    end,
  },

  -- Linting (syntastic alternative)
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        kotlin = { "ktlint" },
      }
    end,
  },

  -- Formatters, linters, code actions (extending built-in LSP)
  {
    "nvimtools/none-ls.nvim", -- formerly null-ls
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.ktlint,
        }
      })
    end,
  },

  {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("bufferline").setup {}
      end,
  },
  
  -- gruvbox color theme
 { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
 {
  "neovim/nvim-lspconfig", -- LSP client
  "williamboman/mason.nvim", -- LSP/DAP/Linter installer
  "williamboman/mason-lspconfig.nvim", -- bridge between mason and lspconfig
  "hrsh7th/nvim-cmp", -- Completion engine
  "hrsh7th/cmp-nvim-lsp", -- Completion source: LSP
  "L3MON4D3/LuaSnip", -- Snippet engine
  "saadparwaiz1/cmp_luasnip", -- Completion source: snippets
 }
}
