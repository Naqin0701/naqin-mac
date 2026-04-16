local ok, headlines = pcall(require, "headlines")
if not ok then
	vim.notify("headlines not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end
