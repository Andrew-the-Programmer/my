#!/bin/bash

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# stty stop undef  # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# [[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
# export TERM='screen-256color'
# set -g defaut-terminal "screen-256color"
# echo "$TERM"
# if [[ "$COLORTERM" = "gnome-terminal" && "$TERM" =~ xterm.* ]]; then
#     echo xD
#     export TERM=vte-256color
# fi

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
# autoload -Uz colors && colors

export EDITOR='nvim'
export VISUAL='nvim'

export XDG_CONFIG_HOME="$HOME/.config"
