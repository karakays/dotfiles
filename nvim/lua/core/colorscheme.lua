-- Transparent background (works with terminal transparency)
require("kanagawa").setup({
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = { bg_gutter = "none" },
      },
    },
  },
  overrides = function(colors)
    return {
      NormalFloat = { fg = colors.theme.ui.float.fg, bg = "none" },
    }
  end,
})

vim.cmd("colorscheme kanagawa-wave")
