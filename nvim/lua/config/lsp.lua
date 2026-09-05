-- Install Mason first for managing servers
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Connect Mason with lspconfig
require("mason-lspconfig").setup({
    -- Automatically install these servers
    ensure_installed = {
        "lua_ls", -- Lua
        -- "pyright",        -- Python
        -- "tsserver",       -- TypeScript/JavaScript
        "rust_analyzer", -- Rust
        "gopls",         -- Go
        --  "clangd",      -- C/C++
    },
})

-- Config applied to every server, merged by name
-- Set up LSP capabilities (used by completion)
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Check if nvim-cmp is available to enhance capabilities
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Function to set up all installed LSP servers
-- Keymaps go on LspAttach now, not on_attach.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        -- Key mappings
        local opts = {
            -- noremap = true
            buffer = ev.buf,
            silent = true,
        }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format({
                async = true
            })
        end, opts)
    end,
})

-- Configure diagnostic display
vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- Could be '■', '▎', 'x'
        source = "if_many",
    },
    float = {
        source = true,
        border = "rounded",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
