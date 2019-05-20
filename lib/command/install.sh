#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
    echo "paki: could not find any suitable package manager in your PATH" 1>&2
    exit 2
fi

case "$LINUX_SYSTEM" in
    debian)
        if [ "$($SUDO_PACKAGER list "$@" 2>/dev/null | wc -l)" -gt 1 ]; then 
            $SUDO_PACKAGER install "$@" 
        elif [ ! -z "$SNAP_PACKAGER" ]; then
            for package in "$@"; do
                if grep -w "$package" "/var/cache/snapd/names" 2>/dev/null 1>&2; then
                    $SNAP_PACKAGER install "$@"
                    exit
                fi
            done
        else
            echo "paki: no matching packages found in remote repositories" 1>&2
            exit 10
        fi
        ;;
    redhat)
        $SUDO_PACKAGER install "$@"
        ;;
    arch)
        $SUDO_PACKAGER -S --needed "$@"
        ;;
    *)
        echo "paki: invalid linux system variable settings" 1>&2
        exit 3
esac

