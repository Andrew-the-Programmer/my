
# Install

```bash
pacman -S yay
alias archi='yay -S --noconfirm'
archi nerd-fonts fzf jump bat tmux zsh stow
archi google-chrome telegram-desktop discord bitwarden

archi prettier typos
archi shfmt shellharden beautysh
archi python-black python-isort python-pylint
archi mdformat tex-fmtdis
```
# Input

1. Edit `~/.config/hypr/input.conf`
2. Set `repeat_delay = 200`
3. Set layout

```conf
  kb_layout = us,ru
  kb_options = compose:caps,grp:alts_toggle
```

> or `alt_space_toggle`

4. Set `natural_scroll = true`

# git

> [[git ssh]], [[git config]]

1. Set config

```bash
git config --global user.name "Andrew"
git config --global user.email "andrey.chikin1223@gmail.com"
```

2. Create ssh key

```bash
> ssh-keygen
> cat ~/.ssh/id_ed25519.pub
```

3. Add ssh to github.
4. Check if `sshd` is started.

```bash
> sudo systemctl status sshd
> sudo systemctl start sshd
```

# Tailscale / VPN

```bash
> yay -S tailscale
> sudo systemctl start tailscaled
> sudo tailscale up
```

# Clone `my` files

```bash
> cd ~
> git clone "git@github.com:Andrew-the-Programmer/my.git"
```

```bash
> git clone "git@github.com:Andrew-the-Programmer/.dotfiles.git" ~/my/dotfiles
> yay -S stow
```
# Keybindings

1. Edit `~/.config/hypr/bindings.conf`
2. Add

```conf
unbind = SUPER, H
unbind = SUPER, J
unbind = SUPER, K
unbind = SUPER, L

bindd = SUPER, H, Move focus left, movefocus, l
bindd = SUPER, J, Move focus down, movefocus, d
bindd = SUPER, K, Move focus up, movefocus, u
bindd = SUPER, L, Move focus right, movefocus, r
```

# Min brightness fix

[The fix - github project](https://github.com/mrdrbrdr/ultra-low-brightness)

**1. Install the script:**

```shell
mkdir ~/external-code
cd ~/external-code
git clone https://github.com/mrdrbrdr/ultra-low-brightness.git
cd ultra-low-brightness
mkdir -p ~/.local/bin
cp brightness-control ~/.local/bin/
chmod +x ~/.local/bin/brightness-control
```

**2. Configure Hyprland:**

Add these lines to `~/.config/hypr/bindings.conf`:

```
# Unbind default brightness controls
unbind = ,XF86MonBrightnessUp
unbind = ,XF86MonBrightnessDown

# Bind ultra-low brightness controls
bindeld = ,XF86MonBrightnessUp, Logarithmic brightness up, exec, ~/.local/bin/brightness-control up
bindeld = ,XF86MonBrightnessDown, Logarithmic brightness down, exec, ~/.local/bin/brightness-control down
```
# Monitors

[hyprmon](https://github.com/erans/hyprmon/)

1. Install TUI for monitors position
   `yay -S hyprmon-bin`
2. Run `hyprmon` in the terminall

# Tmux

1. `~/my/dotfiles/export.sh zsh tmux`
2. [[tmux|Set up tmux]]

# Terminal / Ghostty

1. Set `font-size = 14`
2. Add `command = /bin/zsh`
3. Set `mouse-scroll-multiplier = 1`

# Nvim

LazyVim is a base for omarchy config.
Omarchy adds theme support and some minor things.

plugins/omarchy
plugins/my-plugins

theme.lua -> /home/andrew/.config/omarchy/current/theme/neovim.lua

[LazyVim Keymaps](https://www.lazyvim.org/keymaps)

Extras:
1. [lazyvim.plugins.extras.ai.avante](https://www.lazyvim.org/extras/ai/avante)
2. [lazyvim.plugins.extras.editor.harpoon2](https://www.lazyvim.org/extras/editor/harpoon2)

[[LazyVim Keymaps]]

A lot to change...
# Pass

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
