-- init.lua
require("core.options")
require("core.keymaps")
require("core.lazy")       -- bootstrap and plugin manager setup
require("plugins")
require("core.colorscheme")
require("core.cmp")   -- completion setup
require("core.lsp")   -- language server setup
