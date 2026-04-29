vim.pack.add({
	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		-- To avoid being surprised by breaking changes,
		-- I recommend you set a version range
		version = vim.version.range("^9"),
	},
})

vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {
		hover_actions = {
			auto_focus = true,
		},
		float_win_config = {
			border = "rounded",
		},
	},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- you can also put keymaps in here
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {},
		},
	},
	-- DAP configuration
	dap = {},
}
