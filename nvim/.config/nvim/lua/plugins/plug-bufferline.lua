local ok, bufferline = pcall(require, "bufferline")
if not ok then
	vim.notify("blink.cmp not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

bufferline.setup({})
