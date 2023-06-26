###############################################################################
# *****************           Custom aliases                ***************** #
###############################################################################

# *** Miscellaneous *** #

alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

# Get week number
alias week="date +%V"
# Stopwatch
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"

# in your .bashrc/.zshrc/*rc
alias bathelp="bat --plain --language=help"

help() {
    "$@" --help 2>&1 | bathelp
}

#  *** Directory and App Shortcuts *** #

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias dl="cd $HOME/Downloads"
alias dt="cd $HOME/Desktop"
alias lr="cd $HOME/Documents/learning-resources"
alias dot="cd $HOME/.dotfiles"
alias dev="cd $HOME/Documents/development/"
alias top!="cd $HOME/Documents/development/the-odin-project"
alias media="cd $HOME/Documents/media"
alias library="cd $HOME/Library"
alias personal="$HOME/Documents/personal-projects"

# Google Chrome
# alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# JavaScript shell scripting (JavaScriptCore)
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"

# *** Shell and system properties *** #

# Clear terminal
alias clr="clear"
# Reload shell
alias reload="exec $SHELL -l"
# Reloads the zshrc file
alias zshr="source ~/.config/zsh/.zshrc && echo zsh config reloaded"
# Reloads the zprofile file
alias zshpr="source ~/.config/zsh/.zprofile && echo zprofile reloaded"
# Reloads the bashrc file
alias bashr="source ~/.bashrc && echo Bash config reloaded"
# Check my current shell
alias whichshell="printf 'My current shell is - %s\n' $SHELL"
# Use homebrews zsh
alias brewzsh="sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh"

# Open config files
alias hosts="sudo vim /etc/hosts"
alias zconf="vim $HOME/.dotfiles/.zshrc"
alias zpconf="vim $HOME/.dotfiles/.zprofile"
alias zenv="vim $HOME/.dotfiles/.zshenv"
alias bashrc="vim $HOME/.dotfiles/.bashrc"
alias bashpro="code $HOME/.dotfiles/.bashrc_profile"

# *** Text & directory editing commands *** #

alias mv="mv -v"
alias rm="rm -i -v"
alias cp="cp -v"
alias rd="rmdir"
alias ocd="open ."
alias mk="mkdir"
# Trim new lines and copy to clipboard
alias copy="tr -d '\n' | pbcopy"
# Copy ssh key to pasteboard...
alias pubkey="more ~/.ssh/personal-github.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

# *** Directories and history information *** #

command-history() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
}

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

alias h="history"

# Colorize commands
alias gls="gls --color=always"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias pacman="pacman --color=auto"

# LS Commands
alias ls="ls -f"
alias la="ls -lA"
alias lsh="ls -lah"
alias lsa="ls -flh"
# Only show dot-directories
alias lsd="ls -dl -- .*(/)"
# Only show dot-files
alias lsf="ls -al -- .*(.)"
# List links that point to directories
alias lld="ls -ld *(-/DN)"
# List only file beginning with "."
alias lsdot="ls -ld .*"

#  Color ls
# alias l="colorls"
# alias lc="colorls -lA --sd"
# alias lsc="colorls -1"
# alias lsall="colorls -a"
# alias lsdir="colorls -d"
# alias lsfile="colorls -f"
# alias lstree="colorls --tree"
# alias lslong="colorls -l"
# alias lssortd="colorls --sd"
# alias lssortf="colorls --sf"
# alias lsreport="colorls -r"

# *** tmux *** #

alias tn="tmux new-session -s"
alias tk="tmux kill-session -s"
alias tmn="tmux new -s $(basename $(pwd))"
alias tma="tmux attach -d -t"
alias tml="tmux list-sessions"
alias tconf="nvim ~/.tmux.conf"

# ** Updates *** #

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update —system; sudo gem update"
# Brew update
alias brewupdate="brew update && brew upgrade --all && brew cask update && brew cleanup && brew cask cleanup"

# ** Cleanup options *** #

# Empty trash
alias trash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash/*;"
# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user && killall finder"
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emtrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# *** Volume control *** #

# Volume controls because of http://xkcd.com/530/
alias mute="osascript -e "set volume output muted true""
alias vol1="osascript -e "set volume 1""
alias vol2="osascript -e "set volume 2""
alias vol3="osascript -e "set volume 3""
alias vol4="osascript -e "set volume 4""
alias vol5="osascript -e "set volume 5""
alias vol6="osascript -e "set volume 6""
alias vmax="osascript -e "set volume 7""

# *** File and disk commands *** #

#Files search for dotfiles
alias modifies="find *. -mtime -1 -print | more"
# File size
alias fs="stat -f \"%z bytes\""
# Prints disk usage in human readable form
alias d="sudo du -sh"
alias usage="du -h -d1"
# Display drives and space
alias drives="df -h"
# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Quick chmod ;-)
alias 600="chmod 600" # (rw) Only owner can read/write//#
alias 700="chmod 700" # (rwx) Only owner can read, write and execute//#
alias 644="chmod 644" # (r--) Only owner can write, others can read//#
alias 755="chmod 755" # (r-x) Readable by User, Group and World, writable by User, executable by User//#
alias 754="chmod 754" # (rwx-rx-r) Readable by User, Group and World, writable by User, executable by User and Group//

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd >/dev/null || alias hd="hexdump -C"

# Automatically list directory content when changing directory
#cd() {
#    builtin cd "$@" && ls -la
#}

# *** Network information #

list-network() {
    lsof -i -P -n | awk '/LISTEN/ {print "\033[0;33m" $0 "\033[0m"; next} /ESTABLISHED/ {print "\033[0;32m" $0 "\033[0m"; next} {print "\033[0;31m" $0 "\033[0m"}' | column -t
}

# List open network connections
alias listopen="lsof -i | grep -E '(LISTEN|ESTABLISHED)'"
# List devices
alias listdevs="arp -a"
# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \'Host\: .*|GET \/.*\'"
# Find ip address, default gatway, domain name, DHCP info and network interfaces//
alias ip="ipconfig getifaddr en0"
# List of IP addresses assigned to the network interfaces
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
# Retrieve the public IP address
alias publicip="curl ipecho.net/plain ; echo"
# Get External IP / Internet Speed
alias myip="curl https://ipinfo.io/json"
# Display the number of network interfaces on the system
alias interface="ipconfig ifcount"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# Retrieve detailed network configuration information for en0 (Ethernet interface)
alias dhcp="ipconfig getpacket en0"
# Retrieve the domain name assigned to the specified network
alias domain="ipconfig getoption en0 domain_name"
# Retrieve the domain name server (DNS) configuration for a specific network (en0)
alias nameserver="ipconfig getoption en0 domain_name_server"
# Retrieve the default gateway
alias dgate="route get default | grep gateway"
# Flush the DNS cache on macOS
alias dnsflush="sudo killall -HUP mDNSResponder"
# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# *** CPU and processes

# Get CPU thermal data on MacOS
alias cputemp="sysctl machdep.xcpm.cpu_thermal_level"
# Capture FTP Credentials and Commands
alias capftp="sudo tcpdump -nn -v port ftp or ftp-data"
# List process table
alias ptable="ps -au lukeaimson"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# *** Docker configuration *** #

# Docker
#alias dkrc="docker-compose"
#alias dkr="docker"
#alias flushvolumes="docker volume rm \$(docker volume ls -q)"
#alias flushcontainers="docker rm \$(docker ps -a -q)"
#alias flushimages="docker rmi \$(docker images -q) -f"
#alias flushdocker="flushcontainers && flushimages && flushvolumes"

# *** Git and GitHub configuration *** #

# Git/Github
alias g="git"
alias gi="git init"
# Git add
alias ga="git add ."
alias gau="git add --update"
alias gapa="git add --patch"
# Git branch
alias gb="git branch"
alias gbm="git branch main"
alias gba="git branch -a"
# Git clone
alias gclone="git clone"
alias gcloner="git clone --recursive"
# Git Clean
alias gnuke="git clean -df && git reset --hard"
# Git checkout
alias gcheck="git checkout"
alias gcheckm="git checkout main"
# Git commit
alias gcommitv="git commit -v"
alias gcommit="git commit -m"
alias gcommitam="git commit -am"
# Undo a commit to change it
alias gamend="git commit -a --amend"
# Amend commit message
alias gitreset="git commit --amend --reset-author"
# Git diff
alias gdiff="git diff"
alias gdifft="git diff-tree --no-commit-id --name-only -r"
alias gdiffca="git diff --cached"
# Git fetch
alias gfetch="git fetch"
alias gfetchom="git fetch origin main"
alias gfetchap="git fetch --all --prune"
# Git help
alias ghelp="git help"
# Git log
alias glog="git log"
alias glogsc="git log --stat --color"
alias gloggc="git log --graph --color"
# View abbreviated SHA, description, and history graph of the latest 20 commits.
alias glogol="git log --pretty=oneline -n 20 --graph --abbrev-commit"
