# ~/.zshrc - Zsh Configuration File

# Load Zsh environment variables from ~/.zshenv
source "$HOME/.zshenv"

# Load custom prompt configuration modules
autoload -U colors && colors           # Load colors for prompt customization
autoload -Uz vcs_info                  # Load version control system information (for Git)
autoload -Uz promptinit                # Initialize prompt system
promptinit                            # Start prompt system

# Function to display context information (user@host)
prompt_context() {
  if [[ -n $SSH_CONNECTION ]]; then
    # Display username@hostname in yellow if connected via SSH
    prompt_segment yellow black "%(!.%{%F{red}%}.)%n@%m"
  else
    # Display username@hostname in blue if local
    prompt_segment blue black "%n@%m"
  fi
}

# Function to generate and display Git prompt info
git_prompt_info() {
  # Retrieve the current branch name or return if not in a Git repository
  local ref branch
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return  # Get the current branch reference
  branch=${ref#refs/heads/}                           # Extract the branch name

  # Initialize status variable
  local status=""

  # Check for uncommitted changes (working directory dirty)
  if ! git diff --quiet 2>/dev/null; then
    status="✘"  # Dirty working directory
  fi

  # Check for staged changes
  if ! git diff --cached --quiet 2>/dev/null; then
    status+="⚑"  # Staged changes present
  fi

  # Check for diverged commits (unpushed or unpulled)
  if git rev-list --left-right --count HEAD...@{u} 2>/dev/null | grep -q '^[0-9]\+\s[0-9]\+'; then
    status+="↕"  # Diverged branches (commits ahead/behind)
  fi

  # Default to clean if no status flags
  [[ -z $status ]] && status="✔"

  # Output the final branch and status
  echo "$branch$status"
}

# Function to display Git branch and status in prompt
prompt_git() {
  # Display Git branch and status if in a Git repository
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    prompt_segment green black "%F{yellow}$(git_prompt_info)%f"  # Show Git info in yellow
  fi
}

# Function to display current directory in prompt
prompt_dir() {
  # Show current directory in blue
  prompt_segment blue black "%~"
}

# Add custom prompt segments to the prompt
prompt_functions+=(prompt_context prompt_git prompt_dir)

# Configure vcs_info for Git prompts
zstyle ':vcs_info:git:*' formats '%b'  # Define how Git branch names are displayed

# Allow command substitution and parameter expansion within the prompt string
setopt prompt_subst

# Define the final prompt format combining context, Git info, and directory
PROMPT='${prompt_context} ${prompt_git} ${prompt_dir} %F{green}\$ '

# Configure completion system
ZSH_COMPDUMP="$HOME/.cache/zsh/zcompcache"       # Set directory for completion cache
[[ -d $ZSH_COMPDUMP ]] || mkdir -p "$ZSH_COMPDUMP"  # Create cache directory if it doesn't exist

# Check and load or initialize completion cache
_comp_files=($ZSH_COMPDUMP/zcompdump*(Nm-20^/))
if (($#_comp_files)); then
  autoload -Uz compinit -C -d "$ZSH_COMPDUMP/.zcompdump-${ZSH_VERSION}"  # Load cached completion
else
  autoload -Uz compinit
  compinit -d "$ZSH_COMPDUMP/.zcompdump-${ZSH_VERSION}"  # Initialize and cache completion
fi
unset _comp_files

# Use case-insensitive globbing (matching)
unsetopt case_glob  # Disable case-sensitive globbing

# Enable smart URL handling
autoload -Uz url-quote-magic  # Automatically escape special characters in URLs
zle -N self-insert url-quote-magic  # Bind URL quoting to self-insert

# Configure completion behavior
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _approximate  # Define completion methods
zstyle ':completion:*' expand prefix suffix  # Expand completion prefixes and suffixes
zstyle ':completion:*' group-name ''  # No grouping for completion items
zstyle ':completion:*' list-colors ''  # Default colors for completion list
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s  # Prompt for more completion options
zstyle ':completion:*' list-suffixes true  # Show suffixes for completion
zstyle ':completion:*' matcher-list ''  # Default matchers for completion
zstyle ':completion:*' max-errors 2 numeric  # Max errors for completion
zstyle ':completion:*' menu select=1  # Use menu completion
zstyle ':completion:*' prompt 'Attention: %e error(s) detected'  # Prompt message for errors
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s  # Scrolling prompt message
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'  # File pattern completion
zstyle ':completion:*' verbose true  # Verbose completion messages
zstyle ':completion:*:*:-command-:*:*' group-order builtins commands functions alias  # Command completion group order
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'  # Format for completion messages
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'  # Format for warning messages

# History settings
HISTFILE="$HOME/.cache/zsh/history/.zhistory-${HOST_NAME}"  # Define path for history file
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}  # Create history file directory if it doesn't exist
HIST_STAMPS="dd.mm.yyyy"  # Set timestamp format in history
HISTSIZE=10000  # Maximum number of history entries
SAVEHIST=$HISTSIZE  # Number of history entries to save
fc -R  # Load history from file

# Better history searching
autoload -U up-line-or-beginning-search  # Load history search up-line
autoload -U down-line-or-beginning-search  # Load history search down-line
zle -N up-line-or-beginning-search  # Bind up-line search
zle -N down-line-or-beginning-search  # Bind down-line search

# Terminal settings
unset LSCOLORS  # Unset default LSCOLORS
export LSCOLORS='GxbxCHdxFxDxExBHdxcx'  # Set custom colors for ls command output

# Shell options
setopt complete_aliases             # Complete aliases
setopt always_to_end                # Cursor to end of command line before history substitution
setopt append_history               # Append history to file, not overwrite
setopt auto_cd                      # Automatically change directory when only a path is entered
setopt auto_list                    # Automatically list choices on ambiguous completion
setopt auto_menu                    # Use a completion menu
setopt auto_pushd                   # Automatically pushd to directory stack
setopt completeinword               # Allow completion within a word
setopt correct_all                  # Correct command spelling
setopt extended_glob                # Enable extended globbing patterns
setopt extended_history             # Save timestamps in history
setopt glob_dots                    # Include dotfiles in globbing patterns
setopt hash_list_all                # Hash all commands in the path
setopt hist_expire_dups_first       # Expire duplicate entries first when trimming history
setopt hist_find_no_dups            # Do not display duplicates in history search
setopt hist_ignore_dups             # Do not record duplicates in history
setopt hist_ignore_space            # Do not record commands with leading space in history
setopt hist_reduce_blanks           # Remove extra blanks from history entries
setopt hist_verify                  # Show command before executing after history expansion
setopt histignorespace              # Ignore commands with leading spaces in history
setopt inc_append_history           # Append history incrementally
setopt interactivecomments          # Allow comments in interactive shell
setopt longlistjobs                 # List jobs in long format
setopt no_beep                      # Disable beep on error
setopt prompt_subst                 # Allow prompt substitution