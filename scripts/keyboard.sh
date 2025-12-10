#!/bin/bash

# NOTE: Run with sudo

# milliseconds_before_repeating=220
# repetitions_per_second=60

# xset r rate "$milliseconds_before_repeating" "$repetitions_per_second"

home="/home/andrew"

kanata_exec="$home/.cargo/bin/kanata"
kanata_cfg="$home/.config/kanata/config.kbd"

"$kanata_exec" --cfg "$kanata_cfg"
