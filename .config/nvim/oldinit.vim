" General
" See https://jdhao.github.io for more plugins and stuff about neovim. 

" some general tweaks
" set number	
set linebreak	
set textwidth=70
set showmatch
set showcmd
set spell
set wildmenu
set lazyredraw
set cursorline
set ttyfast

" clipboard and mouse
set mouse=v
set clipboard=unnamedplus
" search
set hlsearch
set smartcase	
set ignorecase	
set incsearch	

" tabs
set autoindent	
set cindent
set shiftwidth=4	
set smartindent	
set smarttab	
set softtabstop=4
set expandtab

" fold
set foldenable
set foldlevelstart=10
set foldnestmax=5
set foldmethod=indent

" Remove visual bell and sound bell
set vb t_vb=

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" Advanced
set ruler
set undolevels=1000	
set backspace=indent,eol,start

" Plug-in
"
" Allow plugins.
filetype plugin on

" LaTeX suite plugin settings
let g:tex_flavor='latex'
" Ultisnips settings 
let g:UltiSnipsExpandTrigger='<tab>'
" Shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" Shortcut to go to previous position 
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" Do not use Ultisnips for LaTeX

" MOLOKAI COLOR SCHEME.
colorscheme molokai

" better colors in terminal
set termguicolors
" Terminal stuff
" Remaps ALT+t to open terminal
nnoremap <M-t> :te<CR>
" Maps Esc to exit Terminal buffer
nnoremap <Esc> <C-\><C-n> 

" Plugin installer via VIM Plug
call plug#begin()
Plug 'gerw/vim-latex-suite'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Pocco81/AutoSave.nvim'
call plug#end()


" Shortcuts and remappings
nnoremap j gj
nnoremap k gk
" Go to the end of a line
nnoremap E $
nnoremap $ <nop>
" Go to the beginning of a line
nnoremap B ^
nnoremap ^ <nop>

" Remaps esc to jk, because Esc is too far away
" if one wants to write jk in vim, just write j and then k
" after the leader-check finished checking (basically wait)
inoremap jk <esc>
inoremap <esc> <nop>
" Set leader key to , since by default is \ which is hard to reach.
let mapleader="," 
" turn off the highlighting once you found what you were looking for
" using search.
nnoremap <leader><space> :nohlsearch<CR>
" to fold/unfold, stay in normal mode and press <space>
nnoremap <space> za
" Split panes vertically
nnoremap <leader>w :vsp<CR>
" Change buffer by <leader> + b, then type the buffer's number
nnoremap <leader>b :b<Space> 

" Highlight selection even in Normal mode.
augroup highlight_yank
    autocmd! 
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}

" Autosave plugin configuration
augroup END
lua << EOF
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
EOF
