#!/bin/bash

# Run install-homebrew script and wait for it to finish
./install-homebrew &&

# Check if Homebrew installation was successful
if command -v brew >/dev/null 2>&1; then
    # Homebrew installed, run brew-zsh script and wait for it to finish
    ./brew-zsh &&

    # Check if zsh installation was successful
    if command -v zsh >/dev/null 2>&1; then
        # zsh installed, run configuration script
        ./link-configs
    else
        echo "Zsh installation failed."
        exit 1
    fi
else
    echo "Homebrew installation failed."
    exit 1
fi
