-- 
-- VIM oIONS
--
vim.o.linebreak = true
vim.o.textwidth = 70
vim.o.showmatch = true
vim.o.showcmd = true
vim.o.spell = true
vim.o.wildmenu = true
vim.o.lazyredraw = true
vim.o.cursorline = true
vim.o.ttyfast = true
-- No backup file
vim.o.backup = false
-- Allow neovim to access the system clipboard
vim.o.clipboard = "unnamedplus"
-- Highlight last search
vim.o.hlsearch = true
-- Do case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Indentation and tabs
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Fold
vim.o.foldenable = false
vim.o.foldlevelstart = 10
vim.o.foldnestmax = 5
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Remove bells
vim.o.belloff = "all"

-- History and other stuff
vim.o.ruler = true
vim.o.undolevels = 400
vim.opt.backspace={"indent", "eol", "start"}

-- Filetype
-- Use filetype.lua and don't fallback to filetype.vim
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
-- to be sure .tex files are recognized as latex...
vim.g.tex_flavor = "latex"

-- Color scheme
vim.o.termguicolors = true
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.cmd([[colorscheme tokyonight]])

-- Autosave setup
local autosave = require("autosave")
autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave","TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
vim.g.autosave_state = true

-- Treesitter
require'nvim-treesitter.configs'.setup {
    highlight = { 
        enable = true, 
        additional_vim_regex_highlighting = false
    }
}
