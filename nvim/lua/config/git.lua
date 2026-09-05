local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

vim.keymap.set('n', ']c', gitsigns.next_hunk, { desc = "Next hunk" })
vim.keymap.set('n', '[c', gitsigns.prev_hunk, { desc = "Previous hunk" })
vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = "Diff this file" })
vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
