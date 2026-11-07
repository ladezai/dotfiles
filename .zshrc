# Keep a lot of history
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000

export EDITOR=nvim
export VISUAL=nvim

# Right prompt
# RPROMPT="%F{255}%K{234}[%D{%f/%m/%y}|%@]"
#PROMPT="%@|$PS1 "
PROMPT="%F{green}%@%F{white}|$PS1"
# Put the prompt 8 lines up from the bottom
# PS1=$'\n\n\n\n\n\n\n\n\e[8A'"$PS1"
# 
### ADDITIONAL COMMANDS
# Add colors ls using ll and lists all files
alias ll="ls --color=tty"
# Use bat instead of cat
alias cat="bat"
# Grep alias to ripgrep
alias grep="rg --max-columns=80"
alias grepfile="rg --files | rg"

### VARIOUS OPTIONS
# Add commands to history as they are entered, don't wait for shell to exit
setopt INC_APPEND_HISTORY
# Also remember command start time and duration
setopt EXTENDED_HISTORY
# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS
# Do not remember commands that start with a whitespace
setopt HIST_IGNORE_SPACE
# Correct spelling of all arguments in the command line
setopt CORRECT_ALL
# Automatically list choices on an ambiguous completion. 
setopt AUTO_LIST
# Enable autocompletion
zstyle ':completion:*' completer _complete _correct _approximate 

## BREW AUTOCOMPLETE
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Python stuff
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# duckdb
export PATH='/Users/gio/.duckdb/cli/latest':$PATH

## PIP3 autocomplete
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip3
# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Autoswitch virtual env
source ~/.zsh/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
# Substring search 
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# Add configuration to zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# SYNTAX HIGHLIGHT 
# choose the theme
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#. "$HOME/.local/bin/env"
#export PATH=/home/gio/.local/bin/uv:$PATH

# Run Pi inside an isolated Podman container mapped to the current directory
source ~/.config/shell-scripts/pi-box/pi-box.sh

# Open clipboard content in Neovim (with ~ and file:// expansion)
v-clip() {
  local raw_clip clipboard_text file_path line_num

  # Fetch clipboard content depending on OS
  if command -v pbpaste >/dev/null 2>&1; then
    raw_clip=$(pbpaste)
  else
    raw_clip=$(xclip -selection clipboard -o 2>/dev/null || xsel --clipboard --output 2>/dev/null)
  fi

  # Trim leading/trailing whitespace & strip quotes or file:// prefix
  clipboard_text=$(echo "$raw_clip" | xargs)
  clipboard_text="${clipboard_text#file://}"

  # Parse path:line syntax
  if [[ "$clipboard_text" =~ ^([^:]+):([0-9]+)$ ]]; then
    file_path="${match[1]:-${BASH_REMATCH[1]}}"
    line_num="${match[2]:-${BASH_REMATCH[2]}}"
  else
    file_path="$clipboard_text"
    line_num=""
  fi

  # Expand tilde (~) manually to $HOME
  file_path="${file_path/#\~/$HOME}"

  # Check if file exists and open in nvim
  if [[ -f "$file_path" ]]; then
    if [[ -n "$line_num" ]]; then
      nvim +"$line_num" "$file_path"
    else
      nvim "$file_path"
    fi
  else
    echo "Clipboard does not contain a valid file path: '$file_path'"
  fi
}
