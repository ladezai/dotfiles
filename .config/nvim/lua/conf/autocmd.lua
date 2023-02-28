-- autocmd create one that autopairs parenthesis.

-- Automatic highlight yanked lines
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup="IncSearch", timeout=450})
    end,
    desc = "Highlight yanked lines"
})


