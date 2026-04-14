local ok, blink = pcall(require, "blink.cmp")
if not ok then
	vim.notify("blink.cmp not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

blink.setup({
	fuzzy = {
		implementation = "lua",
	},
	completion = {
		documentation = { auto_show = true },
		ghost_text = { enabled = true },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
})

local capabilities = blink.get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable({ "lua_ls" })
