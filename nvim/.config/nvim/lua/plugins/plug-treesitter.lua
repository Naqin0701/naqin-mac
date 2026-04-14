-- =======================================================================
-- plugins/plug-treesitter.lua : Neovim treesitter config
-- =======================================================================
local ok, nts = pcall(require, "nvim-treesitter")
if not ok then
	vim.notify("nvim-treesitter not found — check your package spec", vim.log.levels.WARN)
	return
end

-- Parsers to install and activate.
-- These are passed to ensure_installed so nvim-treesitter manages them
-- declaratively; no manual nts.install() call needed.
local parsers = {
	"lua",
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"yaml",
	"bash",
	"regex",
	"go",
	"rust",
	"c",
	"cpp",
	"java",
}

nts.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	ensure_installed = parsers, -- installs missing parsers once on startup, not on every launch
})

-- Enable treesitter features per-buffer via FileType autocmd
local ts_group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = ts_group,
	pattern = parsers,
	callback = function(args)
		local bufnr = args.buf

		-- Guard: buffer may have been wiped before this fires
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		-- Skip silently if no treesitter parser is available for this filetype
		local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
		if not parser_ok or not parser then
			return
		end

		-- 1. Enable treesitter highlighting (native API, Neovim 0.12+)
		pcall(vim.treesitter.start, bufnr)

		-- 2. Enable treesitter-based folding on the associated window.
		--    foldmethod is a window-local option — it cannot be set via vim.bo[].
		local winid = vim.fn.win_findbuf(bufnr)[1]
		if winid and vim.api.nvim_win_is_valid(winid) then
			vim.wo[winid].foldmethod = "expr"
			vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
		-- No fallback: if there is no valid window yet (e.g. headless/test),
		-- folding simply stays at the default — that is safe and correct.

		-- 3. Treesitter-based indentation (optional — disable if behaviour is odd
		--    for a specific language, e.g. Python or HTML)
		vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- 4. Disable legacy :syntax to prevent highlight conflicts
		vim.bo[bufnr].syntax = "off"
	end,
})

-- Global fold defaults
vim.opt.foldenable = false -- start fully unfolded; use zc/zo to fold manually
vim.opt.foldlevel = 99 -- treat all nesting levels as open
