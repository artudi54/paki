#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

nocheck=0

for arg in "$@"; do
    shift
    case "$arg" in
        --yes)
            set -- "$@" "-y" 
            ;;
        *)
            set -- "$@" "$arg"
    esac
done
OPTIND=1
OPTERR=0
while getopts ":y" opt; do
    case "$opt" in
        "y")
            nocheck=1
            ;;
        *)
            show-error-option "paki update" "-$OPTARG"
    esac
done
if [ "$OPTIND" -le "$#" ]; then
    show-error-argument "paki update" "${!OPTIND}"
fi

if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
    echo "paki: could not find any suitable package manager in your PATH" 1>&2
    exit 2
fi

case "$LINUX_SYSTEM" in
    debian)
        if [ "$nocheck" -eq 1 ]; then
            $SUDO_PACKAGER update && $SUDO_PACKAGER full-upgrade -y 
        else
            $SUDO_PACKAGER update && $SUDO_PACKAGER full-upgrade 
        fi
        ;;
    redhat)
        if [ "$nocheck" -eq 1 ]; then
            $SUDO_PACKAGER distro-sync -y
        else
            $SUDO_PACKAGER distro-sync 
        fi
        ;;
    arch)
        if [ "$nocheck" -eq 1 ]; then
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
    if [ "$nocheck" -eq 1 ]; then
        $FLATPAK_PACKAGER update -y
    else
        $FLATPAK_PACKAGER update
    fi
fi

