#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

NOCHECK=0

for arg in "$@"; do
    shift
    case "$arg" in
        --yes)
            set -- "$@" "-y" 
            ;;
    esac
done
OPTIND=1
while getopts "y" opt; do
    case "$opt" in
        "y")
            NOCHECK=1
            ;;
        "*")
            show-error-option "paki update" "$opt"
    esac
done

if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
    echo "paki: could not find any suitable package manager in your PATH" 1>&2
    exit 2
fi

case "$LINUX_SYSTEM" in
    debian)
        if [ "$NOCHECK" -eq 1 ]; then
            $SUDO_PACKAGER update && $SUDO_PACKAGER upgrade -y 
        else
            $SUDO_PACKAGER update && $SUDO_PACKAGER upgrade 
        fi
        ;;
    redhat)
        if [ "$NOCHECK" -eq 1 ]; then
            $SUDO_PACKAGER update -y
        else
            $SUDO_PACKAGER update
        fi
        ;;
    arch)
        if [ "$NOCHECK" -eq 1 ]; then
            $SUDO_PACKAGER -Syu --nocheck
        else
            $SUDO_PACKAGER -Syu
        fi
        ;;
    *)
        echo "paki: invalid linux system variable settings" 1>&2
        exit 3
esac


if [ ! -z "$SNAP_PACKAGER" ]; then
    $SNAP_PACKAGER refresh
fi


if [ ! -z "$FLATPAK_PACKAGER" ]; then
    if [ "$NOCHECK" -eq 1 ]; then
        $FLATPAK_PACKAGER update -y
    else
        $FLATPAK_PACKAGER update
    fi
fi

