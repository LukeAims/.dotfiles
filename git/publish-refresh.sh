#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: ${0##*/} [branch] [remote]

Create (if needed) and push a topic branch for the refreshed dotfiles.

Arguments:
  branch   Name of the branch to push (default: feature/publish-2025-update)
  remote   Remote to push to (default: origin)
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

branch=${1:-feature/publish-2025-update}
remote=${2:-origin}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: ${0##*/} must be run inside a git repository." >&2
  exit 1
fi

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

if [[ -n "$(git status --porcelain)" ]]; then
  cat <<'WARN' >&2
Warning: you have uncommitted changes. Commit or stash them before pushing
if you want the remote branch to match your working tree.
WARN
fi

if ! git remote get-url "$remote" >/dev/null 2>&1; then
  cat <<EOF >&2
Error: remote "$remote" is not configured.
Add it with: git remote add $remote git@github.com:<your-user>/.dotfiles.git
EOF
  exit 1
fi

if ! git rev-parse --verify --quiet "$branch"; then
  echo "Creating local branch '$branch' from current HEAD" >&2
  git branch "$branch"
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$current_branch" != "$branch" ]]; then
  echo "Checking out '$branch'" >&2
  git checkout "$branch"
fi

echo "Pushing '$branch' to '$remote'" >&2

git push -u "$remote" "$branch"
