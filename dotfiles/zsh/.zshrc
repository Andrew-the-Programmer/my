# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/bash

source "$ZDOTDIR/zshrc.sh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
function p10k-configure() {
    source_file="$HOME/.config/zsh/.p10k.zsh"
    configs_folder="$ZDOTDIR/p10k-configs"
    exit_option="exit"
    create_option="create new config"

    selected_config=$(
        {
            ls "$configs_folder" &
            echo "$create_option" &
            echo "$exit_option"
        } |
            fzf --prompt="Select p10k config: "
    )
    if [ "$selected_config" = "$exit_option" ]; then
        if [ ! -f "$source_file" ]; then
            default_config="$configs_folder/personal.zsh"
            cp "$default_config" "$source_file"
        fi
        source "$source_file"
        return 0
    fi
    if [ "$selected_config" = "$create_option" ]; then
        p10k configure || return 1
        read -p "Continue (y/N)?" choice
        case "$choice" in
              y|Y )
                  read -p "Name {}.zsh: " name
                    cp "$source_file" "$configs_folder/$name.zsh"
                    ;;
        esac
        return 0
    fi
    selected_config_file="$configs_folder/$selected_config"
    cp "$selected_config_file" "$source_file"
    source "$source_file"
}

if [ -f ~/.config/zsh/.p10k.zsh ]; then
    source ~/.config/zsh/.p10k.zsh
else
    p10k-configure
fi
