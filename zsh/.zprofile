# Modern login-shell configuration for zsh
# Only login/session wide environment should be configured here.

emulate -LR zsh

# Ensure arrays keep unique values.
typeset -Ug path fpath cdpath manpath

# Base search paths (order matters).
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  "$HOME/.local/bin"
  "$HOME/bin"
  "$path[@]"
)

# Deduplicate while preserving order.
typeset -U path
export PATH

# Homebrew support (both Intel and Apple Silicon).
if command -v brew >/dev/null 2>&1; then
  # shellcheck disable=SC1090
  eval "$(brew shellenv)"
fi

# mise / asdf style runtime managers (2025 recommendation).
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif command -v asdf >/dev/null 2>&1; then
  # shellcheck disable=SC1090
  . "$(asdf dir)/asdf.sh"
elif [[ -d $HOME/.asdf ]]; then
  # shellcheck disable=SC1091
  . "$HOME/.asdf/asdf.sh"
fi

# direnv integration for project-level environments.
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# zoxide for smarter cd if available.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# FPATH additions for completion definitions shipped by package managers.
for completion_dir in \
  /opt/homebrew/share/zsh/site-functions \
  /usr/local/share/zsh/site-functions \
  "$HOME/.local/share/zsh/site-functions"; do
  [[ -d $completion_dir ]] || continue
  fpath=($completion_dir $fpath)
done

export FPATH

# macOS specific defaults.
if [[ $OS_KIND == macos ]]; then
  typeset -gx BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  typeset -gx HOMEBREW_CASK_OPTS='--appdir=~/Applications --fontdir=/Library/Fonts'
  typeset -gx HOMEBREW_NO_ANALYTICS=1
fi
