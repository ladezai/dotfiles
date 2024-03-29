---
--- KEYMAPS
---
local opts   = { silent=true, noremap=true }
local keymap = vim.api.nvim_set_keymap
--local delkeymap = vim.api.nvim_del_keymap

-- set learder key to , 
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","


---
--- Normal mode remapping
---

-- Movement remapping 
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- When change upper to lower or vice-versa, 
-- but don't move the cursor
keymap("n", "~", "~h", opts)

-- Remove highlight after search.
--keymap("n", "<leader><space>", ":noh <CR>", opts)

-- Unfold/folding with space bar 
--keymap("n", "<space>", "za", opts)

-- Better navigation between buffers
keymap("n", "<C-j>", ":bnext <CR>", opts)
keymap("n", "<C-k>", ":bprevious <CR>", opts)
keymap("n", "<C-l>", ":tabnext <CR>", opts)
keymap("n", "<C-h>", ":tabprevious <CR>", opts)


---
--- Insert mode remapping
---

-- Remap esc
keymap("i", "jk", "<ESC>", opts)
--keymap("i", "<ESC>", "<NOP>", opts)

-- Autospell corrector, basically jumps at the previous spell
-- error, correct with the first result.
keymap("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u",opts)


---
--- Visual mode
---

-- Preserves selection when indenting
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)


---
--- Additional maps
---

-- Keymaps for UltiSnips
vim.g.UltiSnipsExpandTrigger="<Tab>"
vim.g.UltiSnipsJumpForwardTrigger="<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger="<S-Tab>"
vim.g.UltiSnipsSnippetDirectories={"UltiSnips","my_snippets"}

-- Keymap for telescope
keymap('n','<leader>t', "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({preview=false}))<CR>", opts)
keymap('n','<leader>g', "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown())<CR>", opts)


-- Keymap to compile LaTeX file and run other kind of programming languages.
--
lang_compile_table = {
    ["tex"]    = ":!lualatex -shell-escape --output-directory '%:p:h' '%:p'",
    ["python"] = ":!python3 '%:p'",
    ["julia"]  = ":!julia %",
    ["rust"]   = ":!cargo check"

}

local code_runner = function()
    local debug = true
    if debug then
        print(vim.bo.filetype)
    end

    local lang = vim.bo.filetype
    local res = lang_compile_table[lang]
    if res == nil then 
        print("Not supported filetype for compilation or execution")
    else
        vim.cmd(res)
    end
end

vim.keymap.set("n", "<leader>c", code_runner, opts)

-- change theme
-- vim.keymap.set("n", "<leader>, vim.o.background="light")
