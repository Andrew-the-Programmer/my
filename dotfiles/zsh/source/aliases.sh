#!/bin/bash

alias ls='ls --color=auto'
alias ll='ls -lhar'
alias zsh-update-plugins="find ""$ZDOTDIR/plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
# alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias lgit="lazygit"

alias oil="nvim +StartOil"

alias dc="docker-compose"

function require_clean_work_tree() {
  # Update the index
  git update-index -q --ignore-submodules --refresh
  err=0

  # Disallow unstaged changes in the working tree
  if ! git diff-files --quiet --ignore-submodules --; then
    echo >&2 "err: you have unstaged changes."
    git diff-files --name-status -r --ignore-submodules -- >&2
    err=1
  fi

  # Disallow uncommitted changes in the index
  if ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
    echo >&2 "err: your index contains uncommitted changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  if [ "$err" = 1 ]; then
    echo >&2 "Please commit or stash them."
    return 1
  fi
}

function sgit() {
  if ! require_clean_work_tree; then
    return 1
  fi
  git "$@"
}

function gsw() {
  sgit switch "$@"
}

alias gst='git status'

zsh_config_file="$ZDOTDIR/.zshrc"

alias zsh-config='nvim $zsh_config_file'
alias zsh-reload='source $zsh_config_file'

alias j="jump"

alias zz="z -"

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

if command -v zoxide &>/dev/null; then
  # alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias d='docker'
alias r='rails'
# nvim
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
alias g='git'

function ChdirToScriptDir() {
  cd "$(dirname "$0")" || return 1
}

function ldir() {
  find . -mindepth 1 -maxdepth 1 -type d \( ! -iname ".*" \) | sed 's|^\./||g'
}

alias gh='google-chrome --proxy-server="http://127.0.0.1:8080"'

function mkdir_cd() {
  args=()
  pos_args=()
  while [[ $# -gt 0 ]]; do
    case $1 in
    --cd)
      do_cd=1
      shift
      ;;
    -*)
      args+=("$1")
      shift
      ;;
    *)
      pos_args+=("$1")
      shift
      ;;
    esac
  done

  /usr/bin/mkdir "${args[@]}" "${pos_args[@]}"

  if [ ! -z "$do_cd" ] && [ "${#pos_args[@]}" -eq 1 ]; then
    builtin cd "${pos_args[@]}" || return 1
  fi
}

alias mkdir='mkdir_cd'

function touch_mkdir() {
  args=()
  pos_args=()
  while [[ $# -gt 0 ]]; do
    case $1 in
    -p)
      do_mkdir=1
      shift
      ;;
    -*)
      args+=("$1")
      shift
      ;;
    *)
      pos_args+=("$1")
      shift
      ;;
    esac
  done

  if [ ! -z "$do_mkdir" ] && [ "${#pos_args[@]}" -eq 1 ]; then
    file="${pos_args[1]}"
    /usr/bin/mkdir -p "$(dirname "$file")"
  fi

  /usr/bin/touch "${args[@]}" "${pos_args[@]}"
}

alias touch='touch_mkdir'

alias fzfd="find . -type d -print | fzf"
alias zf="cd \$(fzfd)"

if ! which bat >/dev/null; then
  alias bat="batcat"
fi

alias fzfp="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""

function ocrpdf() {
  python3 -m ocrmypdf --force-ocr -l eng+rus "$1" "$1"
}

function getext() {
  echo "${1##*.}"
}

function getfilename() {
  echo "${1%.*}"
}

function webptopng() {
  dwebp "$1" -o "$(getfilename "$1").png"
}

function convertext() {
  magick "$1" "$(getfilename "$1").#2"
}

function randfile() {
  find "$1" | shuf -n 1 | tr -d "\n"
}

function copy_image() {
  xclip -selection clipboard -target image/png -i <"$1"
}

function archi() {
  yay -Sy --noconfirm "$@"
}

function debian_install() {
  sudo apt install -y "$@"
}

function sysi() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
  fi
  if [ "$OS" = "Arch Linux" ]; then
    archi "$@"
  elif [ "$OS" = "Ubuntu" ]; then
    debian_install "$@"
  else
    echo "Not supported for your OS"
  fi
}

function py_check_module() {
  python3 -c "import $1" 2>/dev/null || return 1
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

function clip-in() {
  xclip -selection clipboard
}

function clip-out() {
  xclip -selection clipboard -o
}

function my-public-ip() {
  curl -s ifconfig.me
}

function pdf2png() {
  while [[ $# -gt 0 ]]; do
    case $1 in
    -e | --extension)
      ext="$2"
      shift
      shift
      ;;
    -* | --*)
      echo "Unknown option $1"
      return 1
      ;;
    *)
      file="$1"
      shift
      ;;
    esac
  done
  inkscape "$file" "--export-type=$ext"
}

alias vpn-status='echo "Your IP is: $(my-public-ip)"'
alias vpn-up='sudo tailscale up && sudo tailscale set --exit-node="fi-vmpico" && vpn-status'
alias vpn-down='sudo tailscale set --exit-node= && vpn-status'
alias vpn-restart='vpn-down && vpn-up'

alias tailget='sudo tailscale file get .'

alias nvimfzf='nvim "$(fzf)"'

function gpg-export() {
  while [[ $# -gt 0 ]]; do
    case $1 in
    -d | --directory)
      dir="$2"
      shift
      shift
      ;;
    -* | --*)
      echo "Unknown option $1"
      return 1
      ;;
    *)
      key_id="$1"
      shift
      ;;
    esac
  done

  if [ -z "$key_id" ]; then
    echo "Please provide a key id"
    return 1
  fi

  if [ -z "$dir" ]; then
    dir="$HOME/.gpg"
  fi

  mkdir -p "$dir"
  gpg --export-secret-keys --armor "$key_id" >"$dir/private-key.asc"
  gpg --export --armor $key_id >"$dir/public-key.asc"
  #scp -r "$dir" "$target:$dir"
}

nvim-app() {
  NVIM_APPNAME="$1" nvim
}

alias nvim-my='nvim-app nvim-my'
alias nvim-omarchy='nvim-app nvim-omarchy'
alias nvim-lazyvim='nvim-app nvim-lazyvim'

function cat-all() {
  while [[ $# -gt 0 ]]; do
    case $1 in
    --nd)
      nd=1
      shift
      ;;
    *)
      args+=("$1")
      shift
      ;;
    esac
  done

  if [ -z "$nd" ]; then
    args+=("-not" "-path" "*/.git/*" "-type" "f")
  fi

  for file in $(find "${args[@]}"); do
    echo "# FILE: $file"
    echo "\`\`\`"
    cat "$file"
    echo "\`\`\`"
  done
}

function copy-to-nextcloud() {
  local files=()

  while [[ $# -gt 0 ]]; do
    case $1 in
    --user)
      user="$2"
      shift 2
      ;;
    --target-directory)
      target="$2"
      shift 2
      ;;
    -f | --overwrite)
      overwrite=yes
      shift
      ;;
    *)
      files+=("$1")
      shift
      ;;
    esac
  done

  if [ -z "$user" ]; then
    echo "Please provide a --user" && return 1
  fi
  if ! [ -z "$target" ]; then
    target="$target/"
  fi

  # copy-to-nextcloud --user Andrew --target-directory ЦУ ~/OBS/собес\ ЦУ\ 14-01-26.mp4

  docker_container="manual-install-nextcloud-aio-nextcloud-1"
  datadirectory=$(docker exec "$docker_container" awk -F"'" '/datadirectory/ {print $4}' /var/www/html/config/config.php)

  dst="$datadirectory/$user/files/$target"

  docker exec "$docker_container" mkdir -p "$dst"

  for file in "${files[@]}"; do
    exists=$(docker exec "$docker_container" find "$dst" -name "$(basename "$file")")
    exists=yes
    if [ -n "$exists" ] && [ -z "$overwrite" ]; then
      echo "File $(basename "$file") exists in $target. Overwrite? (y/N):"
      read -r reply
    else
      reply="y"
    fi
    if [[ $reply =~ ^[Yy]$ ]]; then
      echo "copy file: $file"
      docker cp "$file" "$docker_container:$dst"
    else
      echo "Copy cancelled."
    fi
  done

  docker exec "$docker_container" chown -R www-data:www-data "$dst"
  docker exec -u www-data "$docker_container" php occ files:scan "$user"
}
