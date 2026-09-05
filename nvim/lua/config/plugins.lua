-- Plugin management

-- Bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Essential plugins
    'nvim-lua/plenary.nvim', -- Utility functions (dependency for many plugins)

    -- Treesitter for syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        priority = 100, -- Load early
    },

    -- Language Server Protocol support
    {
        'neovim/nvim-lspconfig', -- Base LSP configurations
        dependencies = {
            -- Server installation manager
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },

    -- Autocompletion system
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source
            "hrsh7th/cmp-path",   -- Path source
            "L3MON4D3/LuaSnip",   -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippet source
        },
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Key binding helper
    {
        "folke/which-key.nvim",
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- Lazy-load on entering insert mode
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt", "vim" },
                check_ts = true, -- Enable Treesitter-based pairing
            })
        end,
    },

    -- Autoformatter
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                go = { "goimports", "gofmt" }
            },
        }
    },

    -- Theme (load last after all functionality is configured)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- Load first
    },
})
