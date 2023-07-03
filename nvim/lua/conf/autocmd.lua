-- autocmd create one that autopairs parenthesis.

-- Automatic highlight yanked lines
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup="IncSearch", timeout=450})
    end,
    desc = "Highlight yanked lines"
})

--
-- automatically transform text using cesar cipher. 
-- Probably better to use some kind of flag to enable/disable this.
--
-- let cipher = 0
-- vim.api.nvim_create_autocmd("BufReadPost", {
    --command = function()
        --vim.cmd([["+g?]])
    --end,
    --desc = "auto use Cesar's cipher"
--})
--

