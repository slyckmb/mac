# ~/.bashrc: executed by bash(1) for non-login shells.

# Environment variables
# Set GPG options for pass to avoid passphrase prompt
export GPG_TTY=$(tty)
# export PASSWORD_STORE_GPG_OPTS="--no-tty --batch --yes --pinentry-mode loopback"
export PASSWORD_STORE_GPG_OPTS="--no-tty --yes --pinentry-mode loopback"
export GPG_AGENT_INFO=/run/user/$(id -u)/gnupg/S.gpg-agent:0:1
# export PASSWORD_STORE_PASSPHRASE_FILE="$HOME/.password_store_passphrase"
export EDITOR=nano
# export WEECHAT_PASSPHRASE=$(pass show weechat/passphrase)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Source git-prompt.sh if available
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

# Function to get the current Git branch
parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Enhanced colored prompt
PS1='${debian_chroot:+($debian_chroot)}\
\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[31m\] $(parse_git_branch)\[\033[00m\] \$ '

# Enable color support for ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Some additional aliases
alias ll='LC_COLLATE=C LS_COLORS="$LS_COLORS:mh=1;37" ls -lA --si --group-directories-first'
alias tmux="TERM=screen-256color-bce tmux"
alias rebash='source ~/.bashrc'
alias cdp='cd ~/projects'
alias cdd='cd ~/projects/$HOSTNAME/docker'
alias cdg='cd ~/projects/$HOSTNAME'
alias cdt='cd /mnt/media/Downloads/torrents/seeding-glider/_temp'
alias hm='cd ~'
alias cdh='cd ~'

# Path management
export PATH=$PATH:/d/Projects/glider/bin
export PATH=$PATH:~/bin:/home/michael/.local/bin:/usr/local/bin:/usr/bin
export PATH="$HOME/projects/$HOSTNAME/home/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Localization settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Android development
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools

# Java development
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/michael/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/michael/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/michael/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/michael/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Function to extract various archive types
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)  tar xjf "$1" ;;
            *.tar.gz)   tar xzf "$1" ;;
            *.bz2)      bunzip2 "$1" ;;
            *.rar)      unrar x "$1" ;;
            *.gz)       gunzip "$1" ;;
            *.tar)      tar xf "$1" ;;
            *.tbz2)     tar xjf "$1" ;;
            *.tgz)      tar xzf "$1" ;;
            *.zip)      unzip "$1" ;;
            *.Z)        uncompress "$1" ;;
            *.7z)       7z x "$1" ;;
            *)          echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Alias for Git shortcuts
alias gs='git status'
alias gp='git pull'
alias gc='git commit -m'
alias gd='git diff'

# Final clean-up and unset unnecessary variables
unset color_prompt force_color_prompt
