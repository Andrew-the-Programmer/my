#!/bin/bash

sourcedir="$ZDOTDIR/source"
pluginsconfigdir="$ZDOTDIR/plugins-config"

plugins=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "romkatv/powerlevel10k"
    "zsh-users/zsh-history-substring-search"
    "MichaelAquilina/zsh-auto-notify"
    "MichaelAquilina/zsh-you-should-use"
    # "chrissicool/zsh-256color"
)
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

completions=(
    # "esc/conda-zsh-completion"
)

# -----------------------------------------------------------------------------

bashrc="$HOME/.local/share/omarchy/default/bash/zshrc"
if [ -f "$bashrc" ]; then 
    source "$bashrc"
fi

# Plubin Functions
source "$ZDOTDIR/plugin-functions.sh"

# Normal files to source
for f in "$sourcedir"/*;
do
    zsh_add_file "$f"
done

# Plugins
for plugin in "${plugins[@]}";
do
    zsh_add_plugin "$plugin"
done

# Completions
for completion in "${completions[@]}";
do
    zsh_add_completion "$completion" false
done

# Source plugins config files
for f in "$pluginsconfigdir"/*;
do
    zsh_add_file "$f"
done

# fastfetch
