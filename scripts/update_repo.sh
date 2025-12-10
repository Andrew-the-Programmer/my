#!/bin/bash

function error() {
    >&2 echo "$1"
}

repo=$1

if [ "$repo" = "" ]; then
    error "Usage: $0 <repo>" && exit 1
fi

cd "$repo" || (error "repo not found" && exit 1)

git add -A

message="autoupdate $(date "+%F %H:%M")"

git commit -m "$message" || exit 1

(git push && notify-send "pushed $repo") ||
    (error "push failed" && notify-send "failed to push $repo" && exit 1)

echo "successfully updated"
