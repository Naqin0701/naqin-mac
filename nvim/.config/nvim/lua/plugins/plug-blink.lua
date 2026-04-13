local ok, blink = pcall(require, "blink.cmp")
if not ok then
  vim.notify("blink.cmp not found — run :restart to install plugins", vim.log.levels.WARN)
  return
end

blink.setup({
    fuzzy = {
        implementation = "lua",
    }
})
