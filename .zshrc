# Keep a lot of history
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000

# Right prompt
PROMPT="%F{green}%@%F{white}|$PS1"

### ADDITIONAL COMMANDS
# Add colors ls using ll and lists all files
alias ll="ls --color=tty"

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
#source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
