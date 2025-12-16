wg_dir="/etc/wireguard"

pubkey_file="$wg_dir/publickey"
prvkey_file="$wg_dir/privatekey"

function wg-get-privatekey() {
    sudo cat "$prvkey_file"
}
function wg-get-publickey() {
    sudo cat "$pubkey_file"
}

eth_connection=$(ip route | awk '/default/ {print $5}' | head -n 1)
wg_config_file="$wg_dir/$wg_connection.conf"

function wg-select-connection() {
    connections=$(sudo find "$wg_dir" -maxdepth 1 -type f -name "*.conf" -printf "%f\n" | sed 's/\.conf$//')
    wg_connection=$(
        print "$connections" |
            fzf --preview "sudo bat --style=numbers --color=always $wg_dir/{}.conf" --prompt="Select wg connection: "
    )
    # echo "Selected connection: $wg_connection"  # Debug
}

function wg-set-connection() {
    if [ -z "$wg_connection" ]; then
        wg-select-connection
    fi
}

function wg-get-connection() {
    wg-set-connection
    echo "$wg_connection"
}

function wg-set-config-file() {
    wg-set-connection
    wg_config_file="$wg_dir/$wg_connection.conf"
}

function wg-read-config() {
    wg-set-config-file
    sudo bat "$wg_config_file"
}
function wg-edit-config() {
    wg-set-config-file
    sudo nvim "$wg_config_file"
}

function wg-ctl() {
    sudo systemctl "$1" "wg-quick@$2"
}
function wg_m() {
    wg-set-connection
    sudo systemctl "$1" "wg-quick@$wg_connection"
}
function wg-start() {
    wg_m start
}
function wg-stop() {
    wg_m stop
}
function wg-restart() {
    wg_m restart
}
