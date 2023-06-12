#!/usr/bin/env bash

set -e

# Uninstall Homebrew and all packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
rm -rf /usr/local/Homebrew
sudo rm -rf /usr/local/Caskroom
sudo rm -rf /usr/local/Cellar
sudo rm -rf /usr/local/Homebrew
sudo rm -rf /usr/local/bin/brew
sudo rm -rf /usr/local/share/doc/homebrew
sudo rm -rf /usr/local/share/man/man1/brew.1
sudo rm -rf /usr/local/Homebrew

# Remove zsh
sudo dscl . -delete /Users/"$USER" UserShell
sudo rm -rf /usr/local/share/zsh
sudo rm /usr/local/bin/zsh
sudo rm ~/.zshrc

# Check if Oh My Zsh is installed and uninstall if found
if [[ -d ~/.oh-my-zsh ]]; then
    # Oh My Zsh is installed, remove it
    sudo rm -rf ~/.oh-my-zsh
    echo "Oh My Zsh removed."
else
    echo "Oh My Zsh not found"
fi

# Remove dotfiles
cd ~ || exit
rm -rf ~/.dotfiles
rm "$HOME"/.p10k.zsh
rm "$HOME"/.bashrc
rm "$HOME"/.vimrc
rm "$HOME"/.gitconfig
rm "$HOME"/.zprofile
rm  "$HOME"/eslintrc.js 
rm "$HOME"/eslintignore
echo "Cleanup completed. Dotfiles, Homebrew and zsh uninstalled!"
