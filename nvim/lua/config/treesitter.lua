-- treesitter.lua
--@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
    -- Install these parsers by default
    ensure_installed = {
        "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust",
        "go", "html", "css", "json", "yaml", "toml", "markdown", "bash", "cpp"
    },
    auto_install = true, -- Automatically install missing parsers
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]m"] = "@function.outer" },
            goto_previous_start = { ["[m"] = "@function.outer" },
        },
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
        },
    },
}
