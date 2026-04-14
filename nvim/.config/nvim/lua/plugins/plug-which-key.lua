-- =======================================================================
-- plugins/plug-which-key.lua : helps you remember your Neovim keymaps
-- =======================================================================

local ok, wk = pcall(require, "which-key")
if not ok then
	vim.notify("which-key not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

wk.setup()
