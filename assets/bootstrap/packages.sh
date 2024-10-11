#!/usr/bin/env sh

echo 'install packages from packages.txt? [y/n]'
while true; do
    read -r input
    if [ "$input" = "y" ]; then
        paru -Syu --needed - < packages.txt
				exit 0
    elif [ "$input" = "n" ]; then
        echo "Update cancelled. You can run packages.sh again if you have to install the packages again"
				exit 0
    else
        echo "Invalid input. Please press y to continue or n to cancel."
    fi
done
