local ok, nhc = pcall(require, "nvim-highlight-colors")
if not ok then
	vim.notify("nvim-highlight-colors not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

nhc.setup()
