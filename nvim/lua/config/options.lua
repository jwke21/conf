-- Editor options

-- Basic settings
vim.o.number = true         -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.tabstop = 4           -- Number of spaces a tab represents
vim.o.shiftwidth = 4        -- Number of spaces for each indentation
vim.o.expandtab = true      -- Convert tabs to spaces
-- vim.o.smartindent = true      -- Automatically indent new lines
vim.o.wrap = false          -- Line wrapping
vim.o.cursorline = true     -- Highlight current line
vim.o.termguicolors = true  -- Enable 24-bit RGB colors

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Search settings
vim.opt.incsearch = true -- Show matches while typing
vim.opt.hlsearch = true  -- Highlight matches

-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

vim.opt.clipboard = "unnamedplus"
