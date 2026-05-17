-- Use with lazy.nvim (https://github.com/folke/lazy.nvim)
return {
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
          defaults = {
            path_display = { "filename_first" },
            mappings = {
              i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.close,
              },
              n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["q"] = actions.close,
              },
            },
          },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })
      end,
  },

  -- Treesitter for better syntax highlighting + syntax-aware text objects
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "master",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
          -- Disable built-in ftplugin maps (e.g. python's [m/]m) that would shadow textobject moves
          vim.g.no_plugin_maps = true
        end,
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "bash", "go", "gomod", "gosum", "gowork", "helm", "java", "javascript", "json", "kotlin", "lua", "markdown", "python", "tsx", "typescript", "xml", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
      })

      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      local move = require("nvim-treesitter-textobjects.move")

      local select_map = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }
      for lhs, query in pairs(select_map) do
        vim.keymap.set({ "x", "o" }, lhs, function() select(query, "textobjects") end, { desc = query })
      end

      local move_map = {
        goto_next_start     = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end       = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end   = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      }
      for action, maps in pairs(move_map) do
        for lhs, query in pairs(maps) do
          vim.keymap.set({ "n", "x", "o" }, lhs, function() move[action](query, "textobjects") end, { desc = action .. " " .. query })
        end
      end
    end,
  },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = false,
        update_focused_file = {
          enable = true,       -- Auto-highlight current file in tree
          update_root = false, -- Keep tree at project root, don't follow into libraries
        },
        view = { width = 35 },
      })
      vim.keymap.set("n", "<leader>o", ":NvimTreeFindFileToggle<CR>", { desc = "Reveal current file in tree" })
    end,
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
    end,
  },

  -- Open GitHub URLs for current line
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        mappings = nil,
        callbacks = { ["github.com"] = require("gitlinker.hosts").get_github_type_url },
        opts = { action_callback = require("gitlinker.actions").open_in_browser },
      })
      vim.keymap.set({ "n", "v" }, "<leader>gh", require("gitlinker").get_buf_range_url, { desc = "Open in GitHub" })
    end,
  },

  -- Statusline replacement for airline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "kanagawa",
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
  
  -- kanagawa color theme
  { "rebelot/kanagawa.nvim", priority = 1000, config = true },

  -- Render markdown with visual enhancements
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = true,
          icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        },
        code = {
          enabled = true,
          style = "full",
          border = "thin",
        },
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
        },
        checkbox = {
          enabled = true,
          unchecked = { icon = "󰄱 " },
          checked = { icon = "󰄵 " },
        },
        pipe_table = {
          enabled = true,
          style = "full",
        },
      })
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown render" })
    end,
  },
 {
  "neovim/nvim-lspconfig", -- LSP client
  "williamboman/mason.nvim", -- LSP/DAP/Linter installer
  "williamboman/mason-lspconfig.nvim", -- bridge between mason and lspconfig
  "hrsh7th/nvim-cmp", -- Completion engine
  "hrsh7th/cmp-nvim-lsp", -- Completion source: LSP
  "L3MON4D3/LuaSnip", -- Snippet engine
  "saadparwaiz1/cmp_luasnip", -- Completion source: snippets
 },

  -- Keymap discovery popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>c", group = "code/calls" },
        { "<leader>v", group = "vim config" },
        { "<leader>m", group = "markdown" },
        { "<leader>d", group = "document" },
        { "<leader>r", group = "rename" },
      })
    end,
  },
}
