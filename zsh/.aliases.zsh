# Opinionated alias collection refreshed for 2025 shells.

emulate -LR zsh

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_macos() {
  [[ $OSTYPE == darwin* ]]
}

# --------------------------------------------------------------------------------------
# Directory helpers
# --------------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias -- -='cd -'

alias dl='cd "$HOME/Downloads"'
alias dt='cd "$HOME/Desktop"'
alias docs='cd "$HOME/Documents"'
alias proj='cd "$HOME/Documents/development"'
alias dot='cd "$HOME/.dotfiles"'

# --------------------------------------------------------------------------------------
# Listing & navigation (prefer modern tooling when present)
# --------------------------------------------------------------------------------------
if command_exists eza; then
  alias ls='eza --group-directories-first --icons=auto'
  alias la='eza -a --group-directories-first --icons=auto'
  alias ll='eza -al --group-directories-first --icons=auto'
  alias lt='eza -T --level=2 --group-directories-first --icons=auto'
else
  if is_macos; then
    alias ls='ls -GF'
    alias la='ls -GFA'
    alias ll='ls -GFh'
  else
    alias ls='ls --color=auto -F'
    alias la='ls --color=auto -A'
    alias ll='ls --color=auto -alh'
  fi
  alias lt='ls -R | less'
fi

if command_exists zoxide; then
  alias cd='z'
fi

# --------------------------------------------------------------------------------------
# Clipboard & open helpers
# --------------------------------------------------------------------------------------
if command_exists pbcopy; then
  alias copy='pbcopy'
  alias paste='pbpaste'
elif command_exists xclip; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
elif command_exists wl-copy; then
  alias copy='wl-copy'
  alias paste='wl-paste'
fi

if command_exists open; then
  alias o='open'
elif command_exists xdg-open; then
  alias o='xdg-open'
fi

# --------------------------------------------------------------------------------------
# Safer file operations
# --------------------------------------------------------------------------------------
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# --------------------------------------------------------------------------------------
# Git power-ups
# --------------------------------------------------------------------------------------
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpl='git pull --rebase'
alias gst='git status -sb'
alias gss='git status'
alias gsta='git stash push'
alias gstp='git stash pop'

# --------------------------------------------------------------------------------------
# Networking & system helpers
# --------------------------------------------------------------------------------------
if command_exists curl && command_exists jq; then
  alias ipinfo='curl -s https://ipinfo.io/json | jq'
fi

if command_exists ping; then
  alias pingf='ping -c 5 1.1.1.1'
fi

if is_macos; then
  alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
  alias update='softwareupdate -i -a && brew update && brew upgrade && brew cleanup'
elif command_exists apt; then
  alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
fi

alias reload='exec "$SHELL" -l'

# --------------------------------------------------------------------------------------
# Development shortcuts
# --------------------------------------------------------------------------------------
if command_exists docker; then
  alias d='docker'
  alias dps='docker ps'
  alias dcu='docker compose up'
  alias dcd='docker compose down'
fi

if command_exists tmux; then
  alias ta='tmux attach -t'
  alias tk='tmux kill-session -t'
  alias tn='tmux new -s'
  alias tls='tmux list-sessions'
fi

if command_exists kubectl; then
  alias k='kubectl'
  alias kctx='kubectl config use-context'
  alias kns='kubectl config set-context --current --namespace'
fi

if command_exists gh; then
  alias pr='gh pr status'
fi

# Quick editors
if command_exists nvim; then
  alias v='nvim'
  alias vim='nvim'
fi

# --------------------------------------------------------------------------------------
# Misc utilities
# --------------------------------------------------------------------------------------
if command_exists curl; then
  alias weather='curl -s wttr.in'
fi
alias week='date +%V'
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"

if command_exists bat; then
  alias cat='bat --style=plain --paging=never'
fi

if command_exists rg; then
  alias rgi='rg -i'
fi

alias hist='fc -il 1'

# Friendly shrug emoji to clipboard when macOS pbcopy is around.
if command_exists pbcopy; then
  alias shrug="printf '¯\\_(ツ)_/¯' | pbcopy"
fi
