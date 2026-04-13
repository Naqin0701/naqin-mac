-- =======================================================================
-- init.lua : Neovim Entry Point
-- Compatible with : Neovim >= 0.12
-- =======================================================================
-- Load order:
--   1. core/options      - editor behaviour & settings
--   2. core/keymaps      - key bindings (no plugin dependencies)
--   3. core/autocmds     - autocommands
--   4. core/ui           - colorscheme & visual tweaks
--   5. plugins/init      - plugin manager bootstrap
-- =======================================================================


-- Guard: abort early on unsupportes Neovim versions
if vim.fn.has("nvim-0.12") == 0 then
	vim.notify("This config requires Neovim >= 0.12", vim.log.levels.ERROR)
	return
end


require("core.options")
require("core.keymaps")
require("core.lsp")

require("plugins.init")
