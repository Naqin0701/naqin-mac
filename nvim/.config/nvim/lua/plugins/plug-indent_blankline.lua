local ok, ibl = pcall(require, "ibl")
if not ok then
	vim.notify("ibl not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

ibl.setup()
