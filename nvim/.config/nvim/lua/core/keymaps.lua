-- =============================================================================
-- core/keymaps.lua — Key Bindings (no plugin dependencies)
-- =============================================================================

local map = vim.keymap.set

-- Leader Key
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- -----------------------------------------------------------------------------
-- Normal mode
-- -----------------------------------------------------------------------------

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Resize windows with arrow keys
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width"  })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width"  })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer"     })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Better page up/down (keeps cursor centred)
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centred)"   })

-- Keep search matches centred
map("n", "n", "nzzzv", { desc = "Next match (centred)"     })
map("n", "N", "Nzzzv", { desc = "Previous match (centred)" })

-- Quickfix list navigation
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item"     })
map("n", "<leader>co", "<cmd>copen<CR>",  { desc = "Open quickfix list"  })
map("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- Diagnostic navigation (built-in LSP)
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic"     })
map("n", "<leader>dl", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic detail" })
map("n", "<leader>dq", function() vim.diagnostic.setloclist()  end, { desc = "Diagnostics → loclist"  })

-- -----------------------------------------------------------------------------
-- Insert mode
-- -----------------------------------------------------------------------------

-- Fast escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- -----------------------------------------------------------------------------
-- Visual / Visual-block mode
-- -----------------------------------------------------------------------------

-- Stay in indent mode after shifting
map("v", "<", "<gv", { desc = "Shift left and reselect"  })
map("v", ">", ">gv", { desc = "Shift right and reselect" })

-- -----------------------------------------------------------------------------
-- Terminal mode
-- -----------------------------------------------------------------------------

-- Easy exit from terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation from terminal
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Focus left window from terminal"  })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Focus lower window from terminal" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Focus upper window from terminal" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Focus right window from terminal" })
