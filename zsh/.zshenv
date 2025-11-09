# Modernized global environment configuration for zsh
# This file is sourced by every zsh instance, so keep it lightweight and
# limited to pure environment declarations.

emulate -LR zsh

# --------------------------------------------------------------------------------------
# XDG base directory specification
# --------------------------------------------------------------------------------------
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"

# Ensure the directories exist without failing in read-only environments.
for __xdg_dir in "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"; do
  [[ -d $__xdg_dir ]] || mkdir -p "$__xdg_dir" 2>/dev/null
done
unset __xdg_dir

# Adopt XDG layout for zsh if the user symlinks dotfiles to ~/.config/zsh.
if [[ -z ${ZDOTDIR:-} ]]; then
  if [[ -d $HOME/.config/zsh ]]; then
    ZDOTDIR="$HOME/.config/zsh"
  else
    ZDOTDIR="$HOME"
  fi
fi

# --------------------------------------------------------------------------------------
# Locale and language
# --------------------------------------------------------------------------------------
: "${LANG:=en_GB.UTF-8}"
: "${LC_ALL:=$LANG}"
typeset -gx LANG LC_ALL

# --------------------------------------------------------------------------------------
# Editors and tooling defaults
# --------------------------------------------------------------------------------------
: "${VISUAL:=nvim}"
: "${EDITOR:=$VISUAL}"
typeset -gx VISUAL EDITOR

if command -v nvim >/dev/null 2>&1; then
  typeset -gx GIT_EDITOR="$(command -v nvim)"
else
  typeset -gx GIT_EDITOR="$EDITOR"
fi

# Respect terminal truecolour capabilities when available.
typeset -gx COLORTERM="truecolor"

# --------------------------------------------------------------------------------------
# Pager and colors
# --------------------------------------------------------------------------------------
typeset -gx CLICOLOR=1
if command -v bat >/dev/null 2>&1; then
  typeset -gx BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/config"
fi

typeset -gx LESS_TERMCAP_mb=$'\e[1;32m'
typeset -gx LESS_TERMCAP_md=$'\e[1;32m'
typeset -gx LESS_TERMCAP_me=$'\e[0m'
typeset -gx LESS_TERMCAP_se=$'\e[0m'
typeset -gx LESS_TERMCAP_so=$'\e[01;33m'
typeset -gx LESS_TERMCAP_ue=$'\e[0m'
typeset -gx LESS_TERMCAP_us=$'\e[1;4;31m'
typeset -gx MANPAGER='less -R -X'
typeset -gx MANWIDTH=999

# --------------------------------------------------------------------------------------
# Platform detection helpers
# --------------------------------------------------------------------------------------
case $OSTYPE in
  darwin*)
    typeset -gx OS_KIND=macos
    typeset -gx ARCHFLAGS='-arch arm64 -arch x86_64'
    ;;
  linux*)
    typeset -gx OS_KIND=linux
    ;;
  *)
    typeset -gx OS_KIND=unknown
    ;;
esac

typeset -gx HOST_NAME="${HOST_NAME:-${HOST:-$(hostname 2>/dev/null)}}"

typeset -gx GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"

typeset -gx NODE_REPL_HISTORY_SIZE=32768
: "${NODE_REPL_HISTORY:=$XDG_STATE_HOME/node_repl_history}"
typeset -gx NODE_REPL_HISTORY NODE_REPL_MODE=sloppy

typeset -gx PYTHONIOENCODING='UTF-8'

# zsh-autosuggestions defaults (applied even for login shells)
typeset -gx ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1

# Export variables
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME
export ZDOTDIR VISUAL EDITOR GIT_EDITOR COLORTERM CLICOLOR
export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se
export LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us MANPAGER MANWIDTH
export OS_KIND HOST_NAME GPG_TTY NODE_REPL_HISTORY NODE_REPL_HISTORY_SIZE
export NODE_REPL_MODE PYTHONIOENCODING ARCHFLAGS LANG LC_ALL
