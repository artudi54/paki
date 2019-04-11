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
        $SUDO_PACKAGER update && $SUDO_PACKAGER upgrade 
        ;;
    redhat)
        $SUDO_PACKAGER update
        ;;
    arch)
        $SUDO_PACKAGER -Syu
        ;;
    *)
        echo "paki: invalid linux system variable settings" 1>&2
        exit 3
esac

if [ ! -z "$SNAP_PACKAGER" ]; then
    $SNAP_PACKAGER refresh
fi

if [ ! -z "$FLATPAK_PACKAGER" ]; then
    $FLATPAK_PACKAGER update
fi
