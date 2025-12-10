#!/bin/bash

while [[ $# -gt 0 ]]; do
    case $1 in
    -t)
        time="$2"
        shift
        shift
        ;;
    -f)
        logfile="$2"
        shift
        shift
        ;;
    -*)
        echo "Unknown option $1"
        echo "Usage: $0 <repo> [<time_min>] [<logfile>]"
        exit 1
        ;;
    *)
        POSITIONAL_ARGS+=("$1") # save positional arg
        shift                   # past argument
        ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}"

repo=$1

if [ "$logfile" = "" ]; then
    export logfile=~/my/logs/autoupdate_repo.log
fi

if [ "$time_min" = "" ]; then
    export time_min="30m"
fi

if [ "$repo" = "" ]; then
    echo "Usage: $0 [-t <time_min>] [-f <logfile>] <repo>"
    exit 1
fi

function title() {
    echo ">>> $1"
}

function sep() {
    echo "----------------------------------------------" | tee -a "$logfile"
}

while true; do
    sep
    title "$(date "+%F %H:%M"): $repo:" | tee -a "$logfile"
    ~/my/scripts/update_repo.sh "$repo" | tee -a "$logfile"
    sleep "$time"
done
