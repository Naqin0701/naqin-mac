-- =======================================================================
-- plugins/init.lua : Plugins Entry Point
-- =======================================================================

-- Oil plugin : file manager
vim.pack.add({
	-- file explorer
	"https://github.com/stevearc/oil.nvim",
	-- status line
	"https://github.com/nvim-lualine/lualine.nvim",
	-- color schemes
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/catppuccin/nvim",
	-- which key
	"https://github.com/folke/which-key.nvim",
	-- lsp config
	"https://github.com/neovim/nvim-lspconfig",
	-- auto completion
	"https://github.com/saghen/blink.cmp",
	-- Formatter
	"https://github.com/stevearc/conform.nvim",
})

require("plugins.plug-oil")
require("plugins.plug-lualine")
require("plugins.plug-which-key")
require("plugins.plug-blink")
require("plugins.plug-conform")
require("plugins.scheme-setup")
