local ok, tb = pcall(require, "telescope.builtin")
if not ok then
	vim.notify("telescope.builtin not found - run :restart to install plugins", ivm.log.levels.WARN)
	return
end
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Telescope help tags" })

local ok, telescope = pcall(require, "telescope")
if not ok then
	vim.notify("telescope not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

telescope.setup({})
