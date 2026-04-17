local ok, colorizer = pcall(require, "colorizer")
if not ok then
	vim.notify("conform not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

colorizer.setup({})
