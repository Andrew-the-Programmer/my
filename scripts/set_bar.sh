#!/bin/bash

# Terminate already running bar instances
killall -q polybar

theme="material"
launcher="$HOME/.config/polybar/launch.sh --$theme"

# Launch same bar for all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m $launcher &
done
