-- autocmd create one that autopairs parenthesis.

-- Automatic highlight yanked lines
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup="IncSearch", timeout=350})
    end,
    desc = "Highlight yanked lines"
})

-- Disable copilot for large files
--vim.api.nvim_create_autocmd("BufReadPre", {
    --pattern = "*",
    --callback = function() 
        --local f=vim.fn.expand("<afile>")
        --local fsize=vim.fn.getfsize(filename)
--
        --if f > 100000 or f == -2 then
            ---- note: disables copilot only on that buffer
            --vim.b.copilot_enabled = false
        --end
    --end,
    --desc = "Disable Copilot for large or special files on BufReadPre"
--})
--
