local ok, mini_icons = pcall(require, "mini.icons")
if not ok then
	vim.notify("mini_icon not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

mini_icons.setup()
