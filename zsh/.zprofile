#!/usr/bin/env zsh

##############################################################################################################
# ****                        Configure PATH Variables and Program Environments                         **** #
##############################################################################################################

# Enforce uniqueness of data in arrays.
# zsh uses $path array along with $PATH and keeps them in sync
typeset -U PATH path cdpath fpath manpath

# Remove duplicate entries for $PATH
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Manually set the PATH scalar variable (Default path)
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

# Prepend homebrew installed packaged to the PATH variable
export PATH=/usr/local/bin:$PATH

# Set up the necessary environment variables for Homebrew
eval "$(/usr/local/bin/brew shellenv)"

# Initialize rbenv and set up the necessary environment variables for Ruby version management
eval "$(rbenv init - zsh)"

##############################################################################################################
# ****                                    Extracting and Formatting                                     **** #
##############################################################################################################

# Define computer name, so we can pass it to a variable and extract a shortened version
COMPUTER_NAME=$(scutil --get ComputerName)
# Cut the first three characters of computer name
FIRST_THREE=$(echo "$COMPUTER_NAME" | cut -c 1-3)
# Cut the ninth and thirteenth characters of computer name
NINTH=$(echo "$COMPUTER_NAME" | cut -c 9)
THIRTEENTH=$(echo "$COMPUTER_NAME" | cut -c 13)
# Convert the extracted characters to lowercase and store in a variable
SHORT_COMPUTER_NAME="${(L)FIRST_THREE}-${(L)NINTH}${(L)THIRTEENTH}"
