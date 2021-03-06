#
#                   ██
#                  ░██
#    ██████  ██████░██      ██████  █████
#   ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#      ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
# ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#░██ ██████ ██████ ░██  ░██░███   ░░█████
#░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# define path for custom zsh functions and plugins
# contains:
# own plugins and function
# pure theme (symlinked symlinked from git source)
# zsh-syntax-highlighting (symlinked from git source)
export ZSHFUNC=/home/jorick/.zshfunctions
# add custom path to fpath
fpath=( "$ZSHFUNC" $fpath )

zstyle :compinstall filename '/home/jorick/.zshrc'
autoload -Uz compinit
compinit

# Base16 Shell colors
#BASE16_SHELL="$HOME/github/base16-shell/base16-ocean.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# PURE zsh theme
# source and instructions see: https://github.com/sindresorhus/pure

autoload -U promptinit && promptinit

# pure options
PURE_CMD_MAX_EXEC_TIME=60
#PURE_PROMPT_SYMBOL="λ"
#
# load pure
prompt pure
autoload -U colors && colors

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

# PLUGINS
# list plugins
plugins=(grml-comp update golang manpage fix-bluetooth safe-paste zsh-syntax-highlighting)

# Load them from ZSHFUNC location
for plugin ($plugins); do
  source $ZSHFUNC/$plugin.zsh
done

# zsh options
setopt nohashdirs
unsetopt correct_all
setopt correct
setopt completealiases
# ignore command beginning with a space
setopt HIST_IGNORE_SPACE

# shell settings
#set -eu
set -o pipefail
# zsh-syntax-highlighting options
# source and instructions see: https://github.com/zsh-users/zsh-syntax-highlighting

# Keybindings to correct Home, End, Del,... in vi mode
# fix keys home
bindkey -M viins "^[[7~" beginning-of-line
bindkey -M vicmd "^[[7~" beginning-of-line

# fix keys end
bindkey -M viins "^[[8~" end-of-line
bindkey -M vicmd "^[[8~" end-of-line

# fix keys insert
bindkey -M viins "^[[2~" overwrite-mode
bindkey -M vicmd "^[[2~" overwrite-mode

# fix keys delete
bindkey -M viins "^[[3~" delete-char
bindkey -M vicmd "^[[3~" delete-char

# fix keys pgup
bindkey -M viins "^[[5~" up-history
bindkey -M vicmd "^[[5~" up-history

# fix keys pgdown
bindkey -M viins "^[[6~" down-history
bindkey -M vicmd "^[[6~" down-history

# highlighters to use
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line)
# override highlighters
typeset -A ZSH_HIGHLIGHT_STYLES
# remove all underline in main
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=gree,none'

# Stuff transfered from .bashrc
#xhost +local:root > /dev/null 2>&1
#export HISTCONTROL=ignoreboth

# set default apps
export EDITOR="nvim"
export BROWSER=/usr/bin/firefox

# set colors for ls colored output
eval $(dircolors ~/.dircolors)

# set aliasses
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lhs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lla='ls -lahs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias rm='rm -I'
# editor
alias v='nvim'
## Pacman aliasses
alias ipac='sudo pacman -S'
alias spac='pacman -Ss'
alias upac='sudo pacman -Syu'
# emerge aliasses
#alias ipac='sudo emerge --ask'
#alias spac='emerge -s'
#alias upac='sudo emerge --sync && sudo emerge --ask --update --deep --with-bdeps=y @world'
# Pacaur aliasses
alias saur='pacaur -Ss'
alias iaur='pacaur -S'
alias uaur='pacaur -Sua'
# various aliasses
alias google-chrome='google-chrome-stable'
alias um='udiskie-umount'
alias ssh-pi='ssh -p 50299 192.168.0.128'
alias screensaver-off='xset -dpms && xset s off'
alias screensaver-on='xset +dpms && xset s on'
alias mirror-update='sudo reflector -p https -l 100 -f 10 --sort score --save /etc/pacman.d/mirrorlist'
# Copy and paste to/from clipboard
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
# Set pulseaudio volume to valua with pamixer
#alias setvolume='pamixer --set-volume'
# Crazy hacking stuff
alias haxor='cat /dev/urandom | hexdump -C | grep "ca fe"'
#alias twitter='twitter --format ansi'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Path for own scripts
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.config/panel
# Path for local nodejs modules
#export PATH=$PATH:$HOME/node_modules/.bin
# Path for go modules
#export GOPATH=$HOME/gocode
#export PATH=$PATH:$GOPATH/bin
# Path for Haskell modules
export PATH=$PATH:$HOME/.cabal/bin
# Path for ruby gems
#export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin
#export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
#export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin

# Linuxbrew paths
#export PATH=$PATH:$HOME/.linuxbrew/bin
#export MANPATH=$MANPATH:$HOME/.linuxbrew/share/man
#export INFOPATH=$INFOPATH:$HOME/.linuxbrew/share/info
