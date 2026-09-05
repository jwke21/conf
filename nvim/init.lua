-- Initialize core settings
require('config.options')

-- Load plugin manager
require('config.plugins')

-- Set up plugins with dependencies
require('config.treesitter')
require('config.lsp')        -- Depends on language servers being available
require('config.completion') -- Depends on LSP configuration
require('config.telescope')  -- Often integrates with LSP

-- Configure UI components last
require('config.theme')
require('config.statusline')
require('config.explorer')
require('config.git')
