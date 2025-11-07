# Interactive shell configuration embracing 2025 best practices.

emulate -LR zsh

# --------------------------------------------------------------------------------------
# Directories and helper functions
# --------------------------------------------------------------------------------------
: "${ZDOTDIR:=${HOME}/.config/zsh}"
: "${XDG_CACHE_HOME:=${HOME}/.cache}"

ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
ZSH_CACHE_COMPLETIONS_DIR="${ZSH_CACHE_DIR}/completions"
ZSH_CACHE_HISTORY_DIR="${ZSH_CACHE_DIR}/history"
ZSH_CACHE_PLUGIN_FILE="${ZSH_CACHE_DIR}/antidote/plugins.zsh"

mkdir -p "$ZSH_CACHE_COMPLETIONS_DIR" "$ZSH_CACHE_HISTORY_DIR" "${ZSH_CACHE_PLUGIN_FILE:h}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

[[ -d "$HOME/.dotfiles/functions" ]] && fpath=("$HOME/.dotfiles/functions" $fpath)

# --------------------------------------------------------------------------------------
# Options
# --------------------------------------------------------------------------------------
setopt auto_cd autopushd pushd_ignore_dups pushdminus
setopt extended_glob interactivecomments prompt_subst
setopt nocaseglob nobeep
setopt complete_aliases menu_complete auto_menu auto_param_slash
setopt hist_ignore_all_dups hist_reduce_blanks hist_verify
setopt hist_ignore_space share_history inc_append_history extended_history
setopt notify numeric_glob_sort longlistjobs

unsetopt flow_control

# --------------------------------------------------------------------------------------
# Completion setup
# --------------------------------------------------------------------------------------
autoload -Uz compinit bashcompinit
zmodload zsh/complist

if [[ -r $ZSH_CACHE_COMPLETIONS_DIR/zcompdump-${ZSH_VERSION} ]]; then
  compinit -d "$ZSH_CACHE_COMPLETIONS_DIR/zcompdump-${ZSH_VERSION}" -C
else
  compinit -d "$ZSH_CACHE_COMPLETIONS_DIR/zcompdump-${ZSH_VERSION}"
fi

# Enable bash completions when available (brew installs many here).
if [[ -d /opt/homebrew/etc/bash_completion.d ]] || [[ -d /usr/local/etc/bash_completion.d ]]; then
  bashcompinit
  __BASHCOMPINIT_DONE=1
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''
if [[ -n ${LS_COLORS:-} ]]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Re-use dircolors if present.
fi

# --------------------------------------------------------------------------------------
# History configuration
# --------------------------------------------------------------------------------------
HISTFILE="$ZSH_CACHE_HISTORY_DIR/${HOST_NAME:-$HOST}.zhistory"
HISTSIZE=50000
SAVEHIST=50000

# Use better history search bindings.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# --------------------------------------------------------------------------------------
# Prompt configuration (Starship first, modern fallback otherwise)
# --------------------------------------------------------------------------------------
if command_exists starship; then
  eval "$(starship init zsh)"
else
  autoload -Uz colors vcs_info add-zsh-hook promptinit
  colors
  promptinit

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats '%F{yellow} %b%f%F{red}%u%f%F{green}%c%f'
  zstyle ':vcs_info:git:*' actionformats '%F{yellow} %b|%a%f'
  zstyle ':vcs_info:*' check-for-changes true

  prompt_precmd() {
    vcs_info
  }
  add-zsh-hook precmd prompt_precmd

  PROMPT='%B%F{cyan}%n@%m%f%b %F{blue}%~%f ${vcs_info_msg_0_}%f%b%F{green}❯%f '
  RPROMPT='%F{245}%*%f'
fi

# --------------------------------------------------------------------------------------
# Plugin management with Antidote (fast, lazy-loading)
# --------------------------------------------------------------------------------------
ANTIDOTE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
if ! [[ -r $ANTIDOTE_HOME/antidote.zsh ]]; then
  if command_exists git; then
    mkdir -p "${ANTIDOTE_HOME:h}" && \
      git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME" >/dev/null 2>&1 || true
  fi
fi

if [[ -r $ANTIDOTE_HOME/antidote.zsh ]]; then
  source "$ANTIDOTE_HOME/antidote.zsh"
  typeset -ga ZSH_PLUGIN_BUNDLE=(
    zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
  )
  if [[ ! -s $ZSH_CACHE_PLUGIN_FILE || $ANTIDOTE_HOME/antidote.zsh -nt $ZSH_CACHE_PLUGIN_FILE ]]; then
    antidote bundle "${ZSH_PLUGIN_BUNDLE[@]}" >| "$ZSH_CACHE_PLUGIN_FILE"
  fi
  source "$ZSH_CACHE_PLUGIN_FILE"
fi

# --------------------------------------------------------------------------------------
# Tool-specific integrations
# --------------------------------------------------------------------------------------
if command_exists fzf; then
  [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [[ -r /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
fi

if command_exists kubectl; then
  (( $+functions[bashcompinit] )) || autoload -Uz bashcompinit
  if [[ -z ${__BASHCOMPINIT_DONE:-} ]]; then
    bashcompinit 2>/dev/null || true
    __BASHCOMPINIT_DONE=1
  fi
  source <(kubectl completion zsh) >/dev/null 2>&1
fi

# --------------------------------------------------------------------------------------
# Load aliases and functions
# --------------------------------------------------------------------------------------
[[ -f "$ZDOTDIR/.aliases.zsh" ]] && source "$ZDOTDIR/.aliases.zsh"
autoload -U +X source_if_exists 2>/dev/null

# --------------------------------------------------------------------------------------
# Misc quality-of-life tweaks
# --------------------------------------------------------------------------------------
# Highlight the matching bracket momentarily.
if zmodload zsh/complist 2>/dev/null; then
  zstyle ':completion:*' list-prompt '%SScrolling active: current selection at %p%s'
fi

# Use vim-style keybindings by default.
bindkey -v

# Automatically fix simple directory typos.
setopt correct

# Print a friendly header the first time an interactive shell is opened per session.
if [[ -z $ZSH_SESSION_INITIALIZED ]]; then
  export ZSH_SESSION_INITIALIZED=1
  print -P "%F{244}Welcome back, %n! Loaded modern shell profile on %D{%Y-%m-%d}.%f"
fi
