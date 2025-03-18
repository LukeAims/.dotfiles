############################################################################################################
# ****                                    .bash_profile Configuration                                    **** #
###############################################################################################################

# Load .bashrc if it exists (ensures settings apply to login shells)
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Global Environment Variables
export ARCHFLAGS="-arch x86_64"  # Used for compiling software on macOS (Intel architecture)

# XDG Base Directories (Standardising paths)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"

# Language & Encoding Settings
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export PYTHONIOENCODING="UTF-8"

# Preferred Applications
export VISUAL="nvim"  # Default text editor
export GIT_EDITOR="$VISUAL"
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Terminal Output Configuration
export CLICOLOR=1  # Enable colour support
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export VIM_TUI_ENABLE_TRUE_COLOR=1

# Bat Configuration (a `cat` alternative with syntax highlighting)
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

# GPG Configuration
export GPG_TTY="$(tty)"  # Prevents GPG issues in terminal

# Improve grep Output
export GREP_COLOR="1;33"  # Highlighted matches in yellow

# Homebrew Settings
if command -v brew >/dev/null 2>&1; then
    export PATH="/usr/local/bin:$PATH"
    export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --fontdir=/Library/Fonts"
    export HOMEBREW_NO_ANALYTICS=1
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
fi

# Node.js REPL Configuration
export NODE_REPL_HISTORY="$HOME/.node_history"
export NODE_REPL_HISTORY_SIZE="32768"
export NODE_REPL_MODE="sloppy"

# Man Page Configuration
export MANPAGER="less -R -X"
export MANWIDTH=999

# Enhanced LESS_TERMCAP for better man page formatting
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

# System Information
export HOST_NAME="$(scutil --get HostName 2>/dev/null || hostname)"
export KERNEL_NAME="$(uname | tr '[:upper:]' '[:lower:]')"
export OS_KIND="$(uname -s | tr '[:upper:]' '[:lower:]')"