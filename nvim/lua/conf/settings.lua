-- 
-- VIM OPTIONS
--
vim.opt.linebreak = true
vim.opt.textwidth = 70
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.spell = true
vim.opt.wildmenu = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.opt.ttyfast = true
-- No backup file
vim.opt.backup = false
-- Allow neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"
-- Highlight last search
vim.opt.hlsearch = true
-- Do case insensitive search
vim.opt.ignorecase = true

-- Indentation and tabs
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Fold
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 5
vim.opt.foldmethod = "indent"

-- Remove bells
vim.opt.belloff = "all"

-- History and other stuff
vim.opt.ruler = true
vim.opt.undolevels = 400
vim.opt.backspace={"indent", "eol", "start"}

-- Color scheme
vim.opt.termguicolors = true
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
        events = {"InsertLeave", "TextChanged"},
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
