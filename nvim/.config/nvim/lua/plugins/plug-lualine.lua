
local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("lualine not found — run :restart to install plugins", vim.log.levels.WARN)
  return
end

lualine.setup()
