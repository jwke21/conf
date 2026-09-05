require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
    "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust",
    "go", "html", "css", "json", "yaml", "toml", "markdown", "bash", "cpp",
})

-- Highlighting and indentation are Neovim's job now; enable them
-- wherever a parser actually exists.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

-- Textobjects
require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

local function sel(key, query, desc)
    vim.keymap.set({ 'x', 'o' }, key, function()
        select.select_textobject(query, 'textobjects')
    end, { desc = desc })
end

sel('af', '@function.outer', 'a function')
sel('if', '@function.inner', 'inner function')
sel('ac', '@class.outer', 'a struct/interface')
sel('ic', '@class.inner', 'inner struct/interface')
sel('aa', '@parameter.outer', 'a parameter')
sel('ia', '@parameter.inner', 'inner parameter')

vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
    move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Next function' })

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
    move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Previous function' })
