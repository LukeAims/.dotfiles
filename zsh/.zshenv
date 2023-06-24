##############################################################################################################
# ****                                 Global Environment Variables                                     **** #
##############################################################################################################

# Specify the architecture flag for compiling software on macOS. (intel)
export ARCHFLAGS="-arch x86_64"

# XDG Base Specifications (macOS)
export XDG_CONFIG_HOME="$HOME/.config" \
	XDG_CACHE_HOME="$HOME/.cache" \
	XDG_DESKTOP_DIR="$HOME/Desktop" \
	XDG_DOCUMENTS_DIR="$HOME/Documents" \
	XDG_DOWNLOAD_DIR="$HOME/Downloads" \
	XDG_MUSIC_DIR="$HOME/Music" \
	XDG_PICTURES_DIR="$HOME/Pictures"

# Set default language
export LANG="en_GB"
export LC_ALL="en_GB.UTF-8"

# Set preferred editor for local and remote sessions
export VISUAL="/usr/local/bin/nvim"
export GIT_EDITOR="/usr/local/bin/nvim"
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Enable colorized output
export CLICOLOR="true"
# Enabled true color support for terminals (nvim)
export NVIM_TUI_ENABLE_TRUE_COLOR="1"
# Display a wider range of colors (vim)
export VIM_TUI_ENABLE_TRUE_COLOR="1"

# Set config location
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

# Improve color of grep to yellow
export GREP_COLOR='1;33'

# Set Homebrew to install casks to the ~/Applications folder and Fonts to /Library/Fonts"
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Check if Homebrew is installed and add it to the PATH
if command -v brew >/dev/null 2>&1; then
  export PATH="/usr/local/bin:$PATH"

  # Link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded)
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Zsh-Autosuggest
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240" \
	ZSH_AUTOSUGGEST_USE_ASYNC="1" \
	ZSH_AUTOSUGGEST_MANUAL_REBIND="1" \
	ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="1" \
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Set Custom location for zsh startup files
# ZDOTDIR=$HOME/.config/zsh
# export ZDOTDIR

# Configure LESS_TERMCAP for man page highlighting
export LESS_TERMCAP_so=$'\e[01;33m' \
	LESS_TERMCAP_us=$'\e[1;4;31m' \
	LESS_TERMCAP_mb=$'\e[1;32m' \
	LESS_TERMCAP_md=$'\e[1;32m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_ue=$'\e[0m'

# Make sure LESS_TERMCAP is passed to the pager when viewing man pages
export MANPAGER="less -R -X" \
	MANWIDTH=999

# Set host name
HOST_NAME=$(scutil --get HostName)
export HOST_NAME

# Get kernel name
KERNEL_NAME=$(uname | tr '[:upper:]' '[:lower:]')
export KERNEL_NAME

# Grab OS type!
OS_KIND=$(uname)
export OS_KIND
