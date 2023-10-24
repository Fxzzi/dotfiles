#!/usr/bin/env sh

echo "Starting installation of required packages. Press y to continue or n to cancel."
printf "\033[1;31mIf you choose not to install the packages, here be dragons!!\033[0m\n"

while true; do
    read -r input
    if [ "$input" = "y" ]; then
        # Run the update command
        paru -Syu --needed - < packages.txt

        printf "\n\033[1;33mThere may be some packages that weren't installed that are still mentioned in configs.\033[0m\n"
        printf "\033[1;33mThese packages like librewolf, Vesktop, prismlauncher, etc were not included because I'd\033[0m\n"
        printf "\033[1;33mlike to leave these larger packages to user choice.\033[0m\n"
        break
    elif [ "$input" = "n" ]; then
        printf "\nUpdate cancelled.\n"
        break
    else
        printf "\033[1;31mInvalid input. Please press y to continue or n to cancel.\033[0m\n"
    fi
done
