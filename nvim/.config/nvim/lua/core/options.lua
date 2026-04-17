-- =======================================================================
-- core/options.lua : Editor Options
-- =======================================================================

local opt = vim.opt

-- -----------------------------------------------------------------------
-- General
-- -----------------------------------------------------------------------
opt.mouse = "a" -- Enable mouse in all modes
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.undofile = true -- Presist undo history across sessions
opt.swapfile = false -- Disable swap files (use undofile instead)
opt.backup = false
opt.updatetime = 200 -- Faster CursorHold / plugin triggers (ms)
opt.timeoutlen = 300 -- Key sequence timeout (ms)
opt.ttimeoutlen = 10
opt.confirm = true -- Ask before discarding unsaved changes
opt.fileencoding = "utf-8"
opt.autoread = true

-- -----------------------------------------------------------------------
-- UI
-- -----------------------------------------------------------------------
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes:1" -- Always show sign column (prevents jitter)
opt.cursorline = true -- Highlight the current line
opt.wrap = false -- Do not wrap long lines
opt.scrolloff = 8 -- Keep N lines above/below the cursor
opt.sidescrolloff = 8 -- Keep N columns left/right of the cursor

-- -----------------------------------------------------------------------------
-- Indentation & Whitespace
-- -----------------------------------------------------------------------------
opt.tabstop = 4 -- Visual width of a <Tab> character
opt.softtabstop = 4 -- Spaces inserted/deleted on <Tab>/<BS>
opt.shiftwidth = 4 -- Spaces used for auto-indent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Context-aware auto-indenting
opt.shiftround = true -- Round indent to a multiple of shiftwidth

-- -----------------------------------------------------------------------------
-- Search
-- -----------------------------------------------------------------------------
opt.ignorecase = true -- Case-insensitive search by default
opt.smartcase = true -- Case-sensitive when query contains uppercase
opt.hlsearch = true -- Highlight all search matches
opt.incsearch = true -- Show matches as you type
opt.inccommand = "nosplit" -- Live preview of :substitute

-- -----------------------------------------------------------------------------
-- Folding
-- -----------------------------------------------------------------------------
opt.smoothscroll = true

-- -----------------------------------------------------------------------------
-- Grep  (prefer ripgrep when available)
-- -----------------------------------------------------------------------------
if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep --smart-case"
	opt.grepformat = "%f:%l:%c:%m"
end
