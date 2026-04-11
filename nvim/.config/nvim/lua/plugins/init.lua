-- =======================================================================
-- plugins/init.lua : Plugins Entry Point
-- =======================================================================

-- Oil plugin : file manager
vim.pack.add{
    'https://github.com/stevearc/oil.nvim'
}

require('Oil').setup()
