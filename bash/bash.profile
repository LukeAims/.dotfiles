##############################################################################################################
# ****                                    .bash_profile Configuration                                    **** #
##############################################################################################################

# Source the .bashrc if it exists
# Ensures that .bashrc settings are also loaded in login shells.
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Global Environment Variables
# ARCHFLAGS is used for compiling software on macOS (Intel architecture).
export ARCHFLAGS="-arch x86_64"

# XDG Base Directories
# Standardize directory paths according to the XDG Base Directory Specification.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"

# Language Settings
# Set the default language and locale to British English.
export LANG="en_GB"
export LC_ALL="en_GB.UTF-8"

# Set Default Editor and Browser
# These define the preferred text editor and browser, including for Git commits.
export VISUAL="/usr/local/bin/nvim"
export GIT_EDITOR="$VISUAL"
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Terminal Output Configuration
# Enable colored output and true color support in compatible terminals (for nvim and vim).
export CLICOLOR="true"
export NVIM_TUI_ENABLE_TRUE_COLOR="1"
export VIM_TUI_ENABLE_TRUE_COLOR="1"

# Configuration for Bat (a cat clone with syntax highlighting)
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"

# GPG Configuration
# Prevent GPG issues in terminal by setting the correct TTY.
export GPG_TTY=$(tty)

# Improve grep Output
# Set the color for highlighted grep matches to yellow.
export GREP_COLOR='1;33'

# Homebrew Settings
# Set Homebrew's installation directories for applications and fonts, and disable analytics.
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
export HOMEBREW_NO_ANALYTICS=1

# If Homebrew is installed, update PATH and link Rubies to Homebrew's OpenSSL
if command -v brew >/dev/null 2>&1; then
    export PATH="/usr/local/bin:$PATH"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

# Node.js REPL Configuration
# Customize the Node.js REPL history and behavior.
export NODE_REPL_HISTORY=~/.node_history
export NODE_REPL_HISTORY_SIZE='32768'
export NODE_REPL_MODE='sloppy'

# Python Encoding Configuration
# Ensure Python uses UTF-8 encoding for standard I/O.
export PYTHONIOENCODING='UTF-8'

# Configure LESS_TERMCAP for man page highlighting
# These settings improve the appearance of man pages in the terminal.
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

# Man Page Configuration
# Customize the pager and width for man pages.
export MANPAGER="less -R -X"
export MANWIDTH=999

# Host and Kernel Information
# Store the hostname and kernel name in environment variables.
export HOST_NAME=$(scutil --get HostName)
export KERNEL_NAME=$(uname | tr '[:upper:]' '[:lower:]')
export OS_KIND=$(uname)