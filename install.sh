#!/usr/bin/env bash

# Define the path to your dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Check if the ~/.dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    mkdir "$DOTFILES_DIR"
else
    echo "The $DOTFILES_DIR Directory already exists"

fi

# Change to the dotfiles directory
cd "$DOTFILES_DIR" || exit

git clone git@github.com:user/repository.git
# Grab process id of git clone 
clone_pid=$!

# Wait until the git clone operation is finished
wait "$clone_pid"

# Run all dotfiles installers.
set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -name install.sh | while read -r installer; do sh -c "${installer}"; done
