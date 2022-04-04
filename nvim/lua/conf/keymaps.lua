--
-- KEYMAPS
--
local opts   = {silent=true,noremap=true}
local keymap = vim.api.nvim_set_keymap
local delkeymap = vim.api.nvim_del_keymap

keymap("",",","<Nop>",opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Normal mode remapping
-- Movement remapping 
keymap("n","j", "gj",opts)
keymap("n","k", "gk",opts)
-- Go to the end of a line
keymap("n","E", "$",opts)
keymap("n","$", "<Nop>",opts)
-- Go to the beginning of a line
keymap("n", "B", "^",opts)
keymap("n", "^", "<Nop>", opts)
-- Remove highlight after search.
keymap("n", "<leader><space>", ":noh <CR>", opts)

-- Better navigation between tabs
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Insert mode
-- Remap esc
keymap("i", "jk", "<ESC>", opts)
-- Autospell corrector, basically jumps at the previous spell
-- error, correct with the first result.
keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u",opts)
--- delkeymap("<ESC>")

-- Visual mode
-- Preserves selection when indenting
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Keymaps for Ultisnips
vim.g.UltiSnipsExpandTrigger="<Tab>"
vim.g.UltiSnipsJumpForwardTrigger="<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger="<S-Tab>"
vim.g.UltiSnipsSnippetDirectories={"UltiSnips","my_snippets"}

-- Keymaps for hop
keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap('n', 't', "<cmd>lua require'hop'.hint_lines({ current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('n', 'w', "<cmd>lua require'hop'.hint_words({ current_line_only = false, inclusive_jump = true })<cr>", {})

-- Keymap for telescope
keymap('n','<leader>f', "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({preview=false}))<CR>", opts)
keymap('n','<leader>t', "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown())<CR>", opts)


-- Keymap to compile LaTeX file
-- TODO: idea: create a small script that based on file extension
-- activate pdfcompiler (for latex); the interpreter for python (or
-- launches the current script..); and let the same keybinding.
-- Create a table like this, then iterates when <C-x> is pressed.
--local code_pilers = {
--    "file-extension": "command"
--}
keymap("n", "<C-x>", ":!pdflatex -output-directory '%:p:h' '%:p'<CR>", opts)

-- Automatic highlight yanked lines
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=450})]]
