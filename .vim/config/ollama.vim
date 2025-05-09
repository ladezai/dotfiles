" Use Python virtual environment (and install packages via pip)
let g:ollama_use_venv = 1
" Ollama base URL
let g:ollama_host = 'http://localhost:11434'
" tab completion model
let g:ollama_model = 'qwen2.5-coder:7b'
" number of context lines to use for code completion
let g:ollama_context_lines = 7
" debounce time to wait before triggering a completion
let g:ollama_debounce_time = 200

" chat model
let g:ollama_chat_model = 'deepseek-r1:7b'
" override chat system prompt
let g:ollama_chat_systemprompt = "You are an expert software engineer, quite knowledgeable in Python 3.13 and Rust 1.84.\nGuidelines:\n\t1. Always explain your changes and reasoning.\n\t2. Consider edge cases and potential impacts.\n\t3. Follow language-specific best practices.\n\t4. Suggest tests or validation steps when appropriate.\n\t\n\nRemember: You're a senior engineer - be thorough, precise, and thoughtful in your solutions."

" edit model
let g:ollama_edit_model = 'qwen2.5-coder:7b'
" when disabled, LLM changs are applied directly. Useful when tracking changes via Git.
"let g:ollama_use_inline_diff = 0

" debug settings
"let g:ollama_debug = 4
" general log file location
"let g:ollama_logfile = '/tmp/logs/vim-ollama.log'
" ollama chat conversation log
"let g:ollama_review_logfile = '/tmp/logs/vim-ollama-review.log'

" vim: filetype=vim.ollama
