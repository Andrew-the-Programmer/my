#!/bin/bash

HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.miniconda/bin:$PATH
export PATH=$HOME/.local/include:$PATH
export TEXMFHOME=~/texmf
export SUDO_ASKPASS=/usr/local/bin/sudo-askpass
#alias sudo='sudo -A'

# eval "$(fnm env)"
eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
# eval "`pip completion --zsh`"

export PATH=$PATH:~/.spoof-dpi/bin

### Powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# Jump
# source `jump-bin --zsh-integration`

# Set up nvm
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# source "$HOME/.venvs/MyEnv/bin/activate"
