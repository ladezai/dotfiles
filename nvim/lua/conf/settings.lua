------------------------------- 
---       VIM OPTIONS       ---
-------------------------------
vim.o.encoding = "utf-8"
vim.o.relativenumber = true
vim.o.linebreak  = true
vim.o.textwidth  = 80
vim.o.showmatch  = true
vim.o.showcmd    = true
vim.o.wildmenu   = true
vim.o.lazyredraw = true
vim.o.cursorline = true
vim.o.ttyfast    = true

-- spelling
vim.opt.spell      = true
-- the lua way doesn't work so i made this workaround.
--vim.cmd([[set spelllang="en_gb"]])
--vim.opt.spellcapcheck= false

-- Changes the time out for commands, not that 
-- it is particularly useful for exiting insert mode
-- using jk 
vim.o.ttimeout   = true
vim.o.timeout    = true
vim.o.timeoutlen = 200

-- No backup file
vim.o.backup = false
-- autosave when focus is lost/ doesn't seem to work.
-- vim.o.autowrite = true

-- Allow neovim to access the system clipboard
vim.o.clipboard = "unnamedplus"

-- Highlight last search
vim.o.hlsearch = true

-- Do case insensitive search
vim.o.ignorecase = true
vim.o.smartcase  = true

-- Indentation and tabs
vim.o.autoindent  = false
vim.o.shiftwidth  = 4
vim.o.smartindent = true
vim.o.smarttab    = true
vim.o.softtabstop = 4
vim.o.expandtab   = true

-- Fold
vim.o.foldenable     = true
vim.o.foldlevelstart = 10
vim.o.foldnestmax    = 5
vim.wo.foldmethod    = "expr"

-- Remove bells
vim.o.belloff = "all"

-- History and other stuff
vim.o.ruler = true
vim.o.undolevels = 400
vim.opt.backspace={"indent", "eol", "start"}

--- 
--- Filetype
---
-- to be sure .tex files are recognized as latex...
vim.g.tex_flavor = "latex"
-- remove warning for perl and ruby
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- define the path for the python3 executable
vim.g.python3_host_prog = "/opt/homebrew/opt/python3/bin/python3"

-- Tree sitter
require("nvim-treesitter.configs").setup {
    ensure_installed = {"python", "latex", "help", "vim", "lua", "rust"},
    sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true,
    }
}

---
--- Color scheme
--- 
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark  = "mocha",
    },
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true, 
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { },
        loops = {},
        functions = { "italic" },
        keywords = { },
        strings = { "italic" },
        variables = {},
        numbers = { "italic" },
        booleans = { "italic" },
        properties = {},
        types = { "bold" },
        operators = {},
    },
    color_overrides = {
        mocha = {
            base = "#1a1522",
            mantle = "#1a1522",
            crust = "#1a1522",
        } 
    },
    custom_highlights = {},
    integrations = {
        telescope = true,
    }
})

-- setup must be called before loading
vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin")

-- Automatically startup with light / dark mode
local change_theme = function()
    -- run the following cmd
    local cmd = "defaults read -g AppleInterfaceStyle"
    -- read the output
    local handle = io.popen(cmd)
    local val = handle:read("*a")
    -- check if dark string appears
    local rrr = string.find(string.lower(val), "dark")
    -- if dark is found, set to dark, otherwise set to light.
    if rrr ~= nil then
        vim.cmd[[:set background=dark]]
    else 
        vim.cmd[[:set background=light]]
    end
    handle:close()
end

change_theme()
