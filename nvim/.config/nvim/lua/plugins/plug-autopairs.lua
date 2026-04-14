local ok, ap = pcall(require, "nvim-autopairs")
if not ok then
	vim.notify("blink.cmp not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

ap.setup()
