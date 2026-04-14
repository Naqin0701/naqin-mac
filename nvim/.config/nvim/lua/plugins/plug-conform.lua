local ok, conform = pcall(require, "conform")
if not ok then
	vim.notify("conform not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
