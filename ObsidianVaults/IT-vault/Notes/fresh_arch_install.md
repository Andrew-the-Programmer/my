# Packages

```bash
function archi() {
    yay -Sy --noconfirm "$@"
}

function py_check_module() {
    python3 -c "import $1" 2> /dev/null || return 1
    return 0
}

function pyi() {
    module=$1
    pymodule=$2

    if [ -z "$pymodule" ]; then
        pymodule=$module
    fi

    if py_check_module "$pymodule"; then
        echo "$module is already installed"
        return 0
    fi

    sudo pacman -Sy --noconfirm "python-$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pacman"
        return 0
    fi

    pipx install --include-deps "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pipx"
        return 0
    fi

    pip install --user "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pip"
        return 0
    fi

    # https://stackoverflow.com/questions/76499565/python-does-not-find-module-installed-with-pipx
    pip install --user --break-system-packages "$module"
    # "$HOME/.venvs/MyEnv/bin/python" -m pip install --user "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pip --break-system-packages"
        return 0
    else
        echo "$module not installed"
        return 1
    fi
}

for p in ${packages[@]}; do
    archi "$p"
done
```

# Main

- man-db
- git
- docker, docker-compose
- yay
- cargo
- snap
- nerd-fonts
- fzf
- jump
- bat
- nvim
- tmux
- zsh
- kitty
- gem
- npm
- zathura, zathura-pdf-mupdf
- okular
- xdg-utils
  > for xdg-open etc
- perl-file-mimeinfo
  > for mimeopen etc
- texlive, texlive-binextra
  > for latexmk and pdflatex
- obsidian
- inkscape
- discord
- libreoffice
- yandex-music
- nuclear-player-bin
- hiddify

# Pass config

Export GPG key

On provider:

```bash
mkdir ~/.gpg
gpg --export-secret-keys --armor $key_id > ~/.gpg/private-key.asc
gpg --export --armor $key_id > ~/.gpg/public-key.asc
scp -r ~/.gpg $target:~/.gpg
```

On receiver:

```bash
gpg --import ~/.gpg/private-key.asc
```

Init pass

```bash
pass init $key_id
```

Clone pass repo

```bash
git clone git@github.com:Andrew-the-Programmer/pass-password-manager-storage.git ~/.password-store
```

# Git config

## config

```sh
git config --global user.name Andrew
git config --global user.email "andrey.chikin1223@gmail.com"
```

## ssh

### Create ssh key

```bash
ssh-keygen -t ed25519 -C <your_email>
```

> for default file and no passphrase: \<CR\> $\times$ 3

### Copy ssh key to clipboard

#### Windows

```bash
cd C:\Users\<user>
clip < ./.ssh/id_ed25519.pub
```

#### Linux

```bash
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
```

### Add new ssh key to GitHub

`GitHub -> Settings -> SSH and GPG keys -> New SSH key`

# Gnome

## Key press delay

```bash
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```

## Custom keyboard shortcuts

- Launchers / Launch web browser = Super+B
- Navigation / Hide all normal windows = Super+D
- Navigation / Switch to workspace on the left(right) = Ctrl+Super+Left(Right)
- Windows / Close window = Super+C

```bash
setting=org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
gsettings set $setting name 'Launch Kitty'
gsettings set $setting command 'kitty'
gsettings set $setting binding '<Super>t'

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>c']"
```

# Get my/scripts

# Python modules

## ocrmypdf

```bash
archi tesseract-data-<lang> # rus and eng
```

# Latex

https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages

- Export latex packages to ~/texmf/tex/latex
- Run `texhash ~/texmf`.
- Run `mktexlsr ~/texmf`.
  > https://tex.stackexchange.com/questions/32167/texlive-wont-find-files-in-home-texmf
- Add `export TEXMFHOME=~/texmf`.

- Install russian language.

```bash
sudo pacman -Sy texlive-langcyrillic
```

# Bluetooth

```bash
sudo pacman -S bluez
sudo pacman -S bluez-utils
sudo systemctl enable bluetooth.service
```

# Git

Configure your name and email:

```bash
git config --global user.name "Andrew"
git config --global user.email "andrey.chikin1223@gmail.com"
```

# Kitty

- Install themes.

```bash
git clone git@github.com:dexpota/kitty-themes.git ./themes/kitty-themes
git clone git@github.com:catppuccin/kitty.git ./themes/catppuccin
```

# Zsh

```bash
p10k configure
```

# Tmux

- Install tpm - tmux plugin manager.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

- Install plugins. In tmux session press `<prefix> + I`.

- Install catppuccin theme. (https://github.com/catppuccin/tmux/tree/main?tab=readme-ov-file)

```bash
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

# Neovim

## Packages

- https://github.com/stevearc/conform.nvim?tab=readme-ov-file
- https://github.com/mfussenegger/nvim-lint

- prettier (https://github.com/prettier/prettier)
- prettier-latex (https://github.com/siefkenj/prettier-plugin-latex)

```bash
sudo npm install --global prettier prettier-plugin-latex
```

- shfmt (https://github.com/mvdan/sh)
- beautysh (https://github.com/lovesegfault/beautysh)

```bash
pip install beautysh
```

- Shellharden (https://github.com/anordal/shellharden)
- isort (https://github.com/PyCQA/isort)

```bash
pip install isort
```

- black (https://github.com/psf/black)

```bash
pip install black
```

- clang-format (https://clang.llvm.org/docs/ClangFormat.html)

```bash
sudo pacman -Sy --noconfirm clang
```

- uncrustify (https://github.com/uncrustify/uncrustify)
- stylua (https://github.com/JohnnyMorganz/StyLua)
- rubocop (https://github.com/rubocop/rubocop)

```bash
gem install rubocop
```

- markdown-toc (https://github.com/jonschlinkert/markdown-toc)

```bash
sudo npm install -g markdown-toc
```

- mdformat (https://github.com/hukkin/mdformat)

```bash
pipx install mdformat
```

- cmake_format (https://github.com/cheshirekow/cmake_format)

```bash
pipx install cmakelang
```

- sqlfluff (https://github.com/sqlfluff/sqlfluff)
- typos (https://github.com/crate-ci/typos)

```bash
cargo install typos-cli
sudo pacman -S typos
```

- codespell (https://github.com/codespell-project/codespell)
- shellcheck (https://github.com/koalaman/shellcheck)
- pylint (https://pylint.org/)

```bash
pipx install pylint
```

- ruff (https://github.com/astral-sh/ruff)
- selene (https://github.com/Kampfkarren/selene)
- alex (https://alexjs.com/)

```bash
sudo npm install -g alex
```

- markdownlint (https://github.com/DavidAnson/markdownlint)
- proselint (https://github.com/amperser/proselint)

```bash
pipx install proselint
```

- write-good (https://github.com/btford/write-good)

```bash
sudo npm install -g write-good
```

- tex-fmt (https://github.com/WGUNDERWOOD/tex-fmt)

```bash
cargo install tex-fmt
yay -S tex-fmt
```

- llf
- latexindent

## Fixes

- remove line in user.pre-plugins-config.options:

```lua
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview", "popup", "fuzzy" }
```

- Update obsidian.nvim directories.

# Outline

- Install outline

```bash
yay -S outline-client-appimage
```

- Connect to server

```bash
ssh [username]@[server IP]
```

Enter password

- Run the outline command

# ibus

## Not Gnome

```bash
echo "\
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus\
" | sudo tee -a /etc/environment
```

## Gnome

For nvim-ibus-sw.
https://extensions.gnome.org/extension/5497/ibus-switcher/

## Config

```bash
yay -Sy --noconfirm <font>
```

Chinese.

- noto-fonts-sc
- ibus-libpinyin

Russian.

- ttf-paratype
- otf-russkopis

# translate-shell

[github](https://github.com/soimort/translate-shell)

```bash
sudo pacman -Sy --noconfirm translate-shell
```

# pinyin-tool

[github](https://github.com/briankung/pinyin-tool)

```bash
cargo install pinyin-tool
```

# Amnezia

## Install

```bash
archi amneziawg-go
```

## Fix no connection issue

[github issue](https://github.com/amnezia-vpn/amnezia-client/issues/528)

Try `ping google.com`, if it fails:

Assuming you're using NetworkManager:

1. Disable Automatic DNS Configuration:
   Add the following lines to /etc/NetworkManager/NetworkManager.conf:

```conf
[main]
dns=none
rc-manager=unmanaged # to prevent NetworkManager from generating /etc/resolv.conf
```

This prevents NetworkManager from automatically managing DNS configurations.

2. Replace everything in /etc/resolv.conf with this:

```conf
nameserver 1.1.1.1
nameserver 1.0.0.1
```

Now you should be able to browse the web.

# Printers

```bash
archi cups cups-pdf
systemctl enable cups.service
systemctl start cups.service
```

```bash
archi hplip
archi gtk3-print-backends
sudo hp-setup -i
```
