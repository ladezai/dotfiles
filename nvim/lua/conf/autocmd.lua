-- Automatic highlight yanked lines
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup="IncSearch", timeout=350})
    end,
    desc = "Highlight yanked lines"
})

-- Markdown preview
-- View markdown files as HTML on browser
local function markdown_view()
  -- Get the current buffer's file path
  local current_file = vim.fn.expand("%:p")
  local html_file = vim.fn.expand("%:r") .. ".html"

  -- Execute pandoc to convert markdown to HTML with mathjax support
  -- vim.fn.system() for external commands
  vim.fn.system("pandoc --standalone --mathjax -f markdown -t html " .. vim.fn.shellescape(current_file) .. " -o " .. vim.fn.shellescape(html_file))

  -- Open the HTML file 
  -- For cross-platform compatibility, it's often better to use a tool like 'xdg-open' on Linux/WSL, 'open' on macOS, or 'start' on Windows.
  vim.fn.system("open " .. vim.fn.shellescape(html_file))

  -- Call getchar() to pause execution until a key is pressed (optional in Lua, often not needed for backgrounded processes)
  vim.fn.getchar()

  -- Remove the temporary HTML file
  vim.fn.system("rm " .. vim.fn.shellescape(html_file) .. " &")
end

vim.api.nvim_create_user_command('MarkdownView', markdown_view, {
  desc = 'View markdown file as HTML in browser',
  -- buffer = true, -- If you want this command to be buffer-local
  nargs = 0,
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
