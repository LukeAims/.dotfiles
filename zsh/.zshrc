#!/usr/bin/env zsh

#############################################################################################################
# ****                                     Environment Variables                                       **** #
#############################################################################################################

export VISUAL="nvim"
export GIT_EDITOR="nvim"
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Set preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="$VISUAL"
fi

# Link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded)
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Enable colorized output
export CLICOLOR="true"
# Enabled true color support for terminals (nvim)
export NVIM_TUI_ENABLE_TRUE_COLOR="1"
# Display a wider range of colors (vim)
export VIM_TUI_ENABLE_TRUE_COLOR="1"

# Terminal
export TERMINAL="iTerm2"
export ITERM_24BIT="1"
export REPORTTIME="2"
export TIMEFMT="%U user %S system %P cpu %*Es total"
export KEYTIMEOUT="1"
export ITERM_24BIT="1"
export WORDCHARS='*?-[]~\!#%^(){}<>|`@#%^*()+:?'

# Zsh-Autosuggest
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export ZSH_AUTOSUGGEST_USE_ASYNC="1"
export ZSH_AUTOSUGGEST_MANUAL_REBIND="1"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="1"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Set config location
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"


#############################################################################################################
# ****                                     System Variables                                       **** #
#############################################################################################################

# Homebrew install folder
HOMEBREW_FOLDER="/usr/local/share"

# TMUX Settings

# Auto start tmux
ZSH_TMUX_AUTOSTART="true"
# Automatically connect to a previous session if it exists
ZSH_TMUX_AUTOCONNECT="true"

##############################################################################################################
# ****                                        Required Sources                                          **** #
##############################################################################################################

# Source aliases
source "$HOME/.config/zsh/.aliases.zsh"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##############################################################################################################
# ****                                      Load Custom Prompt                                          **** #
##############################################################################################################

# Load and configure the prompt system

# Load colors module for prompt customization.
autoload -U colors && colors

# Load vcs_info module
autoload -Uz vcs_info

# Sets up the `precmd` function, , which is automatically executed before each prompt
precmd() {
  # Retrieves information about the version control status of the current directory
  vcs_info
}

# Load prompt module
autoload -Uz promptinit

# Initialized prompt ready for customization.
promptinit

# Define prompt segments

# Context segment shows username and hostname
prompt_context() {
  if [[ -n $SSH_CONNECTION ]]; then
    prompt_segment yellow black "%(!.%{%F{red}%}.)%n@%m"
  else
    prompt_segment blue black "%n@%m"
  fi
}
# Git segment shows git branch and status
prompt_git() {
  prompt_segment green black "%(!.%{%F{red}%}.)%F{yellow}$(git_prompt_info)%f"
}
# Directory segment shows current directory
prompt_dir() {
  prompt_segment blue black "%F{blue}%~%f"
}

# Add prompt segments to prompt_functions array
prompt_functions+=(prompt_context prompt_git prompt_dir)

# Customize vcs_info formats for git
zstyle ":vcs_info:git:*" formats '%b'

# Allow command substitution and parameter expansion within the prompt string.
setopt prompt_subst

# Define the prompt format
PROMPT='%F{green}%M %F{blue}%~ %F{red}${vcs_info_msg_0_}%f %F{green}\$ '

##############################################################################################################
# ****                             Set Completion location and Settings                                 **** #
##############################################################################################################

# Configure cache file location (zcompdump)
# Load and initialize the completion system ignoring insecure directories with a cache time of 20 hours,
# so it should almost always regenerate the first time a shell is opened each day.
ZSH_COMPDUMP="$HOME/.cache/zsh/zcompcache"

# Create the parent directory if it doesn't exist
[[ -d $ZSH_COMPDUMP ]] || mkdir -p "$ZSH_COMPDUMP"

_comp_files=($ZSH_COMPDUMP/zcompdump*(Nm-20^/))
if (($#_comp_files)); then
  autoload -Uz compinit -C -d "$ZSH_COMPDUMP/.zcompdump-${ZSH_VERSION}"
else
  autoload -Uz compinit
  compinit -d "$ZSH_COMPDUMP/.zcompdump-${ZSH_VERSION}"
fi

# `unset` allows us to customize the location of the cache file (zcompdump)
unset _comp_files

# Use case-insensitive globbing for file matching
unsetopt case_glob

# Enable smart URL handling in the command line.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# The following section sets up completion-related settings

# Configure completion behavior using zstyle commands.
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt 'Attention: %e error(s) detected'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'
zstyle ':completion:*' verbose true

# Set the order of Command Completion Groups
zstyle ':completion:*:*:-command-:*:*' group-order builtins commands functions alias

# Set the colour for completion messages
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

##############################################################################################################
# ****                                Set History Location and Settings                                 **** #
##############################################################################################################

# History Location
HISTFILE="$HOME/.cache/zsh/history/.zhistory-${SHORT_COMPUTER_NAME}"

# Create the parent directory if it doesn't exist
[[ -d ${HISTFILE:h} ]] || {
  zmodload -m -F zsh/files b:zf_mkdir
  zf_mkdir -p ${HISTFILE:h}
}

# Set the history file
HISTFILE="$HISTFILE"
# You can set one of the optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications, (see 'man strftime' for details)
HIST_STAMPS="dd.mm.yyyy"
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Initialize the history
fc -R

# Better history (for previous commands)

# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

##############################################################################################################
# ****                                            Set ls_colors                                         **** #
##############################################################################################################

# Avoid duplicates from other programs

unset LSCOLORS

export LSCOLORS='GxbxCHdxFxDxExBHdxcx'

##############################################################################################################
# ****                                           Set Options                                            **** #
##############################################################################################################

setopt complete_aliases       # Enables alias expansion during command-line completion.
setopt always_to_end          # When completing a word, move the cursor to the end of the word
setopt append_history         # This is default, but set for share_history
setopt auto_cd                # `cd` by typing directory name if it's not a command
setopt auto_list              # Automatically list choices on ambiguous completion
setopt auto_menu              # Automatically use menu completion
setopt auto_pushd             # Make cd push each old directory onto the stack
setopt completeinword         # If unset, the cursor is set to the end of the word
setopt correct_all            # Autocorrect commands
setopt extended_glob          # Treat #, ~, and ^ as part of patterns for filename generation
setopt extended_history       # Save each command's beginning timestamp and duration to the history file
setopt glob_dots              # Dot files included in regular globs
setopt hash_list_all          # When command completion is attempted, ensure the entire  path is hashed
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups      # When searching history don't show results already cycled through twice
setopt hist_ignore_dups       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space      # Remove command line from history list when first character is a space
setopt hist_reduce_blanks     # Remove superfluous blanks from history items
setopt hist_verify            # Show command with history expansion to user before running it
setopt histignorespace        # Remove commands from the history when the first character is a space
setopt inc_append_history     # Save history entries as soon as they are entered
setopt interactivecomments    # Allow use of comments in interactive code (bash-style comments)
setopt longlistjobs           # Display PID when suspending processes as well
setopt no_beep                # Silence all bells and beeps
setopt nocaseglob             # Global substitution is case insensitive hist
setopt nonomatch              # Try to avoid the 'zsh: no matches found...'
setopt noshwordsplit          # Use zsh style word splitting
setopt notify                 # Report the status of backgrounds jobs immediately
setopt numeric_glob_sort      # Globs sorted numerically
setopt prompt_subst           # Allow expansion in prompts
setopt pushd_ignore_dups      # Don't push duplicates onto the stack
setopt share_history          # Share history between different instances of the shell

##############################################################################################################
# ****                                          Key Bindings                                            **** #
##############################################################################################################

# Vim keybindings
bindkey -v

# Bind up key to function
bindkey "^[[A" up-line-or-beginning-search
# Bind down key to function
bindkey "^[[B" down-line-or-beginning-search
# Bind the Alt (Option) key and the left arrow key to the beginning-of-line
bindkey '^[^[[D' beginning-of-line
# Bind the Alt (Option) key and the right arrow key to the end-of-line
bindkey '^[^[[C' end-of-line
# Bind the Option (Alt) key + Command (⌘) key + Right Arrow to forward-word
bindkey '^[[1;9C' forward-word
# Bind the Option (Alt) key + Command (⌘) key + Left Arrow to backward-word
bindkey '^[[1;9D' backward-word
# Bind the Command (⌘) key and the up arrow key to the beginning-of-buffer-or-history
bindkey '^[[1;5A' beginning-of-buffer-or-history
# Bind the Command (⌘) key and the down arrow key to the end-of-buffer-or-history
bindkey '^[[1;5B' end-of-buffer-or-history
# Bind the Command (⌘) key and the delete key to the kill-word
bindkey '^[[3;5~' kill-word
# Bind the delete key to the delete-char
bindkey '^[[3~' delete-char

##############################################################################################################
# ****                                        Shell Integration                                         **** #
##############################################################################################################

# iTerm2 Shell Integration
test -e /Users/lukeaimson/.config/zsh/.iterm2_shell_integration.zsh && source /Users/lukeaimson/.config/zsh/.iterm2_shell_integration.zsh || true

# Display  neofetch on terminal start
neofetch