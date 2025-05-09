set nocompatible
filetype off  
syntax on
set tabstop=4
set softtabstop=4 
set expandtab
set number! relativenumber!

call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-highlightedyank'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'gergap/vim-ollama'
call plug#end()

" Remap the > to >gv so that the selected selection is preserved
:vnoremap < <gv
:vnoremap > >gv
" Remap ij to ESC in insert mode
:inoremap jk <ESC> 
" Remap j to gj and similarly for k
:nnoremap j gj
:nnoremap k gk
:nnoremap ~ ~h
:nnoremap <C-l> :bnext<CR>
:nnoremap <C-k> :bprevious<CR>

" Set tex flavor
let g:tex_flavor = "latex"
" Set up UltiSnips mainly for LaTeX
" :echo g:UltiSnipsSnippetDirectories
let g:UltiSnipsSnippetDir="~/.vim/my_snippets"
let g:UltiSnipsSnippetDirectories=["my_snippets"]
" Ultisnips settings 
let g:UltiSnipsExpandTrigger='<TAB>'
" Shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<TAB>'
" Shortcut to go to previous position 
let g:UltiSnipsJumpBackwardTrigger='<C-TAB>'
" Do not use Ultisnips for LaTeX


" set highlight to 300 ms
let g:highlightedyank_highlight_duration = 300

" Set up ALE server for python and rust
let g:ale_linters = {'python': ['ruff']}
let g:ale_fixers = {'python': ['ruff_format'], 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']}

" Set up ruff options
let g:ale_python_ruff_format_options = '--line-length=120'
let g:ale_python_ruff_options = '--select=I,E,F,UP,B,SIM --ignore=UP007,UP006,E501 --line-length=120'

" Set ALE lint and fix behaviour
let g:ale_python_ruff_use_global = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0

