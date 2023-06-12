#!/usr/bin/env bash

# Check to see what shell we are using then execute the zsh or bash version of the test

if [ -n "$BASH_VERSION" ]; then
  if test ! "$(uname)" = "Darwin"; then
    exit 0
  fi
elif [ -n "$ZSH_VERSION" ]; then
  # Shell is Zsh
  if [[ ! "$(uname)" = "Darwin" ]]; then
    exit 0
  fi
else
  echo "Unsupported shell"
  exit 1
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installable's in the Mac App Store. So lets check...

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a
