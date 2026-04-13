-- =======================================================================
-- plugins/plug-oil.lua : Plugins Entry Point
-- =======================================================================

local ok, oil = pcall(require, "Oil")
if not ok then
  vim.notify("Oil not found — run :restart to install plugins", vim.log.levels.WARN)
  return
end

oil.setup()

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {desc = "Oil file explorer"})
