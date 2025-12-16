#!/bin/bash

cd "$(dirname "$0")" || exit

packages_to_export=()

while [[ $# -gt 0 ]]; do
	case $1 in
	--all)
		ALL=TRUE
		shift # past argument
		shift # past value
		;;
	-*)
		echo "Unknown option $1"
		exit 1
		;;
	*)
		packages_to_export+=("$1") # save positional arg
		shift                      # past argument
		;;
	esac
done

if [ -n "$ALL" ]; then
	packages_to_export=($(find . -mindepth 1 -maxdepth 1 -type d \( ! -iname ".*" \) | sed 's|^\./||g'))
fi

for package in "${packages_to_export[@]}"; do
	eval "./$package/.export"
done
