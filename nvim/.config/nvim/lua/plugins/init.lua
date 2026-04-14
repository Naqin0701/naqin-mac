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
	-- indent blank line
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	-- tree sitter (archived at 20260404)
	"https://github.com/nvim-treesitter/nvim-treesitter",
	-- mini.icon icon lib
	"https://github.com/nvim-mini/mini.icons",
	-- auto pairs
	"https://github.com/windwp/nvim-autopairs",
})

-- plugins
require("plugins.plug-oil")
require("plugins.plug-lualine")
require("plugins.plug-which-key")
require("plugins.plug-blink")
require("plugins.plug-conform")
require("plugins.plug-indent_blankline")
require("plugins.plug-treesitter")
require("plugins.plug-mini_icon")
require("plugins.plug-autopairs")

-- schemes
require("plugins.scheme-setup")
