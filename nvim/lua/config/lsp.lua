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
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "ts_ls",         -- TypeScript/JavaScript
        "rust_analyzer", -- Rust
        "gopls",         -- Go
        "clangd",        -- C/C++
        "bashls",        -- Bash
        "marksman",      -- Markdown
        "taplo",         -- TOML
        "jsonls",        -- JSON
        "yamlls",        -- YAML
        "dockerls",      -- Docker
        "terraformls",   -- Terraform
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

        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, vim.tbl_extend('force', opts, {
                desc = desc,
            }))
        end


        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('K', vim.lsp.buf.hover, 'Hover docs')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
        map('gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('gR', vim.lsp.buf.references, 'References')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('<leader>lf', function()
            vim.lsp.buf.format({
                async = true
            })
        end, 'Format buffer')
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
