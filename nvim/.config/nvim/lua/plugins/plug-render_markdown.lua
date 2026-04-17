-- =======================================================================
-- plugins/plug-render_markdown.lua : Plugins Entry Point
-- =======================================================================

local ok, render_markdown = pcall(require, "render-markdown")
if not ok then
	vim.notify("render_markdown not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

render_markdown.setup({})
