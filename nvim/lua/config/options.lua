-- Editor options

-- Basic settings
vim.o.number = true         -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.tabstop = 4           -- Number of spaces a tab represents
vim.o.shiftwidth = 4        -- Number of spaces for each indentation
vim.o.expandtab = true      -- Convert tabs to spaces
-- vim.o.smartindent = true      -- Automatically indent new lines (not needed because of treesitter's indent)
vim.o.wrap = false          -- Line wrapping
vim.o.cursorline = true     -- Highlight current line
vim.o.termguicolors = true  -- Enable 24-bit RGB colors
vim.o.splitbelow = true     -- horizontal splits open below
vim.o.splitright = true     -- vertical splits open to the right

-- Search behavior
vim.o.ignorecase = true  -- case-insensitive search...
vim.o.smartcase = true   -- ...unless the query contains a capital
vim.opt.incsearch = true -- Show matches while typing
vim.opt.hlsearch = true  -- Highlight matches

-- Editing quality of life
vim.o.undofile = true    -- persist undo history across sessions
vim.o.scrolloff = 8      -- keep 8 lines of context around the cursor
vim.o.updatetime = 250   -- faster CursorHold (diagnostics, gitsigns)
vim.o.signcolumn = "yes" -- always show gutter; prevents text jitters

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', {
    silent = true,
    desc = "Save file",
})

vim.opt.clipboard = "unnamedplus"


-- Terminal window settings

-- open new terminal with "<Space>t"
vim.keymap.set("n", "<leader>t", "<cmd>botright split | resize 15 | terminal<CR>", {
    desc = "Terminal below",
})
-- map <Esc> to exit terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
    desc = "Exit terminal mode",
})

-- Window splits
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", {
    desc = "Vertical split",
})
vim.keymap.set("n", "<leader>s", "<cmd>split<CR>", {
    desc = "Horizontal split",
})
