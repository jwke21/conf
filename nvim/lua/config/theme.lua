require("catppuccin").setup({
    flavour = "mocha", -- latte | frappe | macchiato | mocha
    integrations = {
        cmp = true,
        treesitter = true,
        telescope = {
            enabled = true
        },
        nvimtree = true,
        which_key = true,
        mason = true,
        native_lsp = {
            enabled = true
        },
    },
})

vim.cmd.colorscheme("catppuccin")
